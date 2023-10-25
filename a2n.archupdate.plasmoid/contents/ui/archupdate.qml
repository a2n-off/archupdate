import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15

import org.kde.plasma.plasmoid 2.0

import "../_toolbox" as Tb
import "../service" as Sv

Item {
    id: archupdate

    Plasmoid.preferredRepresentation: Plasmoid.compactRepresentation
    Plasmoid.compactRepresentation: Compact {}

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
}
