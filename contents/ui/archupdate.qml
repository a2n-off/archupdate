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
      // todo do something for that, maybe w/ fakeroot
      // with paru -Syu the db is updated w/ no sudo
      // executable.exec("echo -e 'no\n' | sudo pacman -Syu")
      // sleep(5)
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
      triggeredOnStart: true // trigger on start for a first checkind
      onTriggered: count()
    }

    // setup the ui and the output
    Plasmoid.compactRepresentation: Item {
      id: compactRepresentation
      
      Image {
        id: updateIcon
        fillMode: Image.PreserveAspectFit
        height: parent.height
        width: height
        sourceSize: Qt.size(height, height)
        smooth: true
        source: "../assets/system-software-update-grey-02"
      }
      
      // background for the text
      Rectangle {
        id: circle
        width: 16
        height: width
        radius: width / 2
        color: "Black"
        opacity: 0.7
        visible: true
        anchors {
          right: parent.right
          top: parent.top
        }
      }

      // total of update
      Text {
        text: root.total
        font.pointSize: 8
        color: "White"
        anchors.centerIn: circle
        visible: circle.visible
      }

      // setup action for click event
      MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: { count() }
      }

    }

}
