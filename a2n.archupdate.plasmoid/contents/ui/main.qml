import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

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

    // this is mendatory to have that in the root elem's : https://techbase.kde.org/Development/Tutorials/Plasma4/JavaScript/API-PlasmoidObject#Context_menu
    function action_launchUpdate() {
        updater.launchUpdate()
    }

    Component.onCompleted: {
      Plasmoid.setAction("launchUpdate", "Update", "preferences-other")
      checker.konsole()
      checker.checkupdates()
    }

    toolTipItem: Loader {
        id: tooltipLoader
        Layout.minimumWidth: item ? item.implicitWidth : 0
        Layout.maximumWidth: item ? item.implicitWidth : 0
        Layout.minimumHeight: item ? item.implicitHeight : 0
        Layout.maximumHeight: item ? item.implicitHeight : 0
        source: "Tooltip.qml"
    }
}
