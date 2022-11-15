import QtQuick 2.1
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.4

import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents

import org.kde.taskmanager 0.1 as TaskManager
import org.kde.plasma.private.taskmanager 0.1 as TaskManagerApplet
import org.kde.kwindowsystem 1.0 as KWindowSystem

Item {
    id: root

    property int total: 0

    Plasmoid.preferredRepresentation: Plasmoid.compactRepresentation

    // count the number of update
    function count() {
      root.total = root.total + 1
    }

    // execute function count each 30 minutes
    Timer {
      id: timer
      interval: 1000 // ms
      running: true
      repeat: true
      onTriggered: count()
    }

    // setup the ui and the output
    Plasmoid.compactRepresentation: Item {
      id: output

      PlasmaCore.IconItem {
          source: ""
      }

      PlasmaComponents.Label {
        id: label
        text: root.total
        width: parent.width
        height: parent.height
        anchors.fill: parent
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
      }
    }

}
