import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import org.kde.plasma.core as PlasmaCore

import org.kde.plasma.plasmoid

import "../_toolbox" as Tb
import "../service" as Sv

PlasmoidItem {
    id: main

    property string totalArch: "0"
    property string totalAur: "0"

    preferredRepresentation: compactRepresentation
    compactRepresentation: Compact {

        onTotalArchChanged: {
            main.totalArch = totalArch
        }
        onTotalAurChanged: {
            main.totalAur = totalAur
        }
    }
    fullRepresentation: ColumnLayout {}

    // load one instance of each needed service
    Sv.Updater{ id: updater }
    Sv.Checker{ id: checker }
    Tb.Cmd { id: cmd }

    Component.onCompleted: {
      checker.konsole()
      checker.checkupdates()
    }

    Plasmoid.contextualActions: [
        PlasmaCore.Action {
            text: i18n("Update")
            icon.name: "preferences-other"
            onTriggered: {
                updater.launchUpdate()
            }
        }
    ]

    toolTipItem: Loader {
        id: tooltipLoader
        Layout.minimumWidth: item ? item.implicitWidth : 0
        Layout.maximumWidth: item ? item.implicitWidth : 0
        Layout.minimumHeight: item ? item.implicitHeight : 0
        Layout.maximumHeight: item ? item.implicitHeight : 0
        source: "Tooltip.qml"
    }
}
