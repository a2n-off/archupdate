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
    property bool isOnDebug: plasmoid.configuration.debugMode
    property bool isOnUpdate: false
    property string tArch: "0"
    property string tAur: "0"
    property string listAur: ""
    property string listArch: ""

    // load one instance of each needed service
    Sv.Updater{ id: updater }
    Sv.Checker{ id: checker }
    Sv.Debug{ id: debug }

    // the brain of the widget
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
            if (isOnDebug) debug.log('ARCHUPDATE - cmd connected: ' + source, false)
            isUpdating(true)
            connected(source)
        }

        onExited: function (cmd, exitCode, exitStatus, stdout, stderr) {
            if (isOnDebug) debug.log('ARCHUPDATE - cmd exited: ' + JSON.stringify({cmd, exitCode, exitStatus, stdout, stderr}), stderr !== "")

            // update the count after the update
            if (isOnUpdate || stdout === '') { // eg. the stdout is empty if the user close the update term with the x button, or if stderr is pop
                isOnUpdate = false
                updater.countAll()
            }

            // handle the result for the count
            const cmdIsAur = cmd === plasmoid.configuration.countAurCommand
            const cmdIsArch = cmd === plasmoid.configuration.countArchCommand
            if (cmdIsArch) {
                let total = stdout.replace(/\n/g, '')
                totalArch(total)
                main.tArch = total
            }
            if (cmdIsAur) {
                let total = stdout.replace(/\n/g, '')
                totalAur(total)
                main.tAur = total
            }

            // handle the result for the list
            const cmdIsListAur = cmd === plasmoid.configuration.listAurCommand
            const cmdIsListArch = cmd === plasmoid.configuration.listArchCommand
            if (cmdIsListAur) listAur = stdout
            if (cmdIsListArch) listArch = stdout
            if (cmdIsListAur || cmdIsListArch) {
                packagesList(listAur + listArch)
            }


            // handle the result for the checker
            if (cmd === "konsole -v") checker.validateKonsole(stderr)
            if (cmd === "checkupdates --version") checker.validateCheckupdates(stderr)

            isUpdating(false)
        }

        // execute the given cmd
        function exec(cmd: string) {
            if (!cmd) return
            connectSource(cmd)
        }

        signal isUpdating(bool status)
        signal packagesList(string list)
        signal totalAur(string total)
        signal totalArch(string total)
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
        return !(tArch === "0" && tAur === "0")
    }
    Plasmoid.status: hasUpdate() ? PlasmaCore.Types.ActiveStatus : PlasmaCore.Types.PassiveStatus

    // map the UI
    compactRepresentation: Compact {}
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
