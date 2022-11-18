import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import "../service" as Service

RowLayout {
  id: row

  property int margin: 2
  property string iconUpdate: "../assets/software-update-available.svg"
  property string iconRefresh: "../assets/arch-unknown.svg"
  property string total: "0"

  // service import
  Service.Updater { id: updater }

  anchors.fill: parent // the row fill the parent in height and width
  anchors.topMargin: margin // margin give a better look for the icon in the panel
  anchors.bottomMargin: margin

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
      onClicked: {
        updateUi(true, "↻")
        updater.count((value) => updateUi(false, value))
      }
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
