import QtQuick 2.1
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.4

import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents

Item {
    id: root

    property string total: "0"

    Plasmoid.preferredRepresentation: Plasmoid.compactRepresentation
    
    // setup the data source for the command
    PlasmaCore.DataSource {
      id: executable
      engine: "executable"
      connectedSources: []
      onNewData: {
        var exitCode = data["exit code"]
        var exitStatus = data["exit status"]
        var stdout = data["stdout"]
        var stderr = data["stderr"]
        exited(sourceName, exitCode, exitStatus, stdout, stderr)
        disconnectSource(sourceName)
      }

      function exec(cmd) {
        if (cmd) connectSource(cmd)
      }

      signal exited(string cmd, int exitCode, int exitStatus, string stdout, string stderr)
    }

    // count the number of update
    function count() {
      root.total = "↻"
      executable.exec("pacman -Sup | wc -l")
    }

    // map the stdout with the widget
    Connections {
      target: executable
      function onExited(cmd, exitCode, exitStatus, stdout, stderr) {
        // remove the leading newline
        var output = stdout.replace(/\n/g, '')
        root.total = output
      }
    }

    // execute function count each 30 minutes
    Timer {
      id: timer
      interval: 1800000 // ms
      running: true
      repeat: true
      onTriggered: count()
    }

    // setup the ui and the output
    Plasmoid.compactRepresentation: Item {
      id: output

      //PlasmaCore.IconItem {
      //  source: "/home/a2n/Nextcloud/save_linux_21/wallpaper-and-icon/archlinux-logo.svg"
      //  implicitHeight: parent.height
      //}

      PlasmaComponents.Label {
        id: label
        text: root.total
        width: parent.width
        height: parent.height
        anchors.fill: parent
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
      }

      // setup action for click event
      MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: { count() }
      }
    }

}
