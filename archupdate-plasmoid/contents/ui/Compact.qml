import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15

import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 3.0 as PlasmaComponents

import "../service" as Service
import "../toolbox" as Tb

RowLayout {
  id: row

  property int margin: 2
  property string iconUpdate: "../assets/software-update-available.svg"
  property string iconRefresh: "../assets/arch-unknown.svg"
  property string total: "0"

  Service.Updater { id: updater }
  Tb.Cmd { id: cmd }

  anchors.fill: parent // the row fill the parent in height and width
  anchors.topMargin: margin // margin give a better look for the icon in the panel
  anchors.bottomMargin: margin

  // map the result
  // TODO place this fc in another service
  Connections {
    target: cmd.executable
    function onExited(cmd, exitCode, exitStatus, stdout, stderr) {
      var output = stdout.replace(/\n/g, '') // remove the leading newline
      updateUi(false, output)
    }
  }

  // execute function count each 30 minutes
  // TODO place this fc in another service
  Timer {
    interval: 1800000 // ms
    running: true
    repeat: true
    triggeredOnStart: true // trigger on start for a first checkind
    onTriggered: startRefresh()
  }

  // refresh the ui and launch the count
  function startRefresh() {
    updateUi(true, "↻")
    updater.count()
  }

  // updates the text and the icon according to the refresh status
  function updateUi(refresh: boolean, value: text) {
    refresh ? icon.source= iconRefresh : icon.source= iconUpdate
    total=value
  }

  Image {
    id: icon
    height: row.height
    width: height
    Layout.fillWidth: true
    fillMode: Image.PreserveAspectFit
    sourceSize: Qt.size(height, height) // w/ the sourceSize set to the height the svg have alway the right definition
    source: iconUpdate
    cache: false

    MouseArea {
      anchors.fill: icon // cover all the zone
      cursorShape: Qt.PointingHandCursor // give user feedback
      onClicked: { startRefresh() }
    }

    // background for the text
    Rectangle {
      id: circle
      width: icon.width / 3
      height: width
      radius: width / 2
      color: "Black"
      opacity: 1
      anchors.right: parent.right
      anchors.bottom: parent.bottom

      // total of update
      Text {
        text: total
        font.pointSize: 8
        color: "White"
        anchors.centerIn: circle
      }
    }
  }

}
