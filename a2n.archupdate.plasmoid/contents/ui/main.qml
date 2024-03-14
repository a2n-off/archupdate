import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import org.kde.plasma.core as PlasmaCore

import org.kde.plasma.plasmoid
import org.kde.plasma.plasma5support as Plasma5Support

import "../_toolbox" as Tb
import "../service" as Sv

PlasmoidItem {
    id: main

    property int intervalConfig: plasmoid.configuration.updateInterval
    property string totalArch: "0"
    property string totalAur: "0"

    signal updatingList()
    signal stoppedUpdatingList()

    // load one instance of each needed service
    Sv.Updater{ id: updater }
    Sv.Checker{ id: checker }
    Sv.Debug{ id: debug }

    Plasma5Support.DataSource {
        id: cmd
        engine: "executable"
        connectedSources: []

        onNewData: function (sourceName, data) {
            var exitCode = data["exit code"]
            var exitStatus = data["exit status"]
            var stdout = data["stdout"]
            var stderr = data["stderr"]
            exited(sourceName, exitCode, exitStatus, stdout, stderr)
            disconnectSource(sourceName)
        }

        onSourceConnected: function (source) {
            main.updatingList()
            connected(source)
        }

        onExited: function (cmd, exitCode, exitStatus, stdout, stderr) {
            main.stoppedUpdatingList()
        }

        // execute the given cmd
        function exec(cmd: string) {
            if (!cmd) return
            connectSource(cmd)
        }

        signal connected(string source)
        signal exited(string cmd, int exitCode, int exitStatus, string stdout, string stderr)
    }

    // execute function count each updateInterval minutes
    Timer {
        id: timer
        interval: intervalConfig * 60000 // minute to milisecond
        running: true
        repeat: true
        triggeredOnStart: true // trigger on start for a first check
        onTriggered: updater.countAll()
    }

    // handle the "show when relevant" property for the systray
    function hasUpdate() {
        return !(totalArch === "0" && totalAur === "0")
    }
    Plasmoid.status: hasUpdate() ? PlasmaCore.Types.ActiveStatus : PlasmaCore.Types.PassiveStatus

    // map the UI
    compactRepresentation: Compact {
        onTotalArchChanged: {
            main.totalArch = totalArch
        }
        onTotalAurChanged: {
            main.totalAur = totalAur
        }
    }
    fullRepresentation: Full {}

    // map the context menu
    Plasmoid.contextualActions: [
        PlasmaCore.Action {
            text: i18n("Update")
            icon.name: "install-symbolic"
            onTriggered: {
                updater.launchUpdate()
            }
        },
        PlasmaCore.Action {
            text: i18n("Refresh")
            icon.name: "view-refresh-symbolic"
            onTriggered: {
                updater.countAll()
            }
        }
    ]

    // load the tooltip
    toolTipItem: Loader {
        id: tooltipLoader
        Layout.minimumWidth: item ? item.implicitWidth : 0
        Layout.maximumWidth: item ? item.implicitWidth : 0
        Layout.minimumHeight: item ? item.implicitHeight : 0
        Layout.maximumHeight: item ? item.implicitHeight : 0
        source: "Tooltip.qml"
    }

    // launch a check for the dependancies
    Component.onCompleted: {
        checker.konsole()
        checker.checkupdates()
        plasmoid.configuration.debugLog = "" // clear log window
    }
}
