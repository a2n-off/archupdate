import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15

import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.workspace.components 2.0 as WorkspaceComponents

Row {
  id: row

  property string iconUpdate: "../assets/software-update-available.svg"
  property string iconRefresh: "../assets/arch-unknown.svg"
  property string totalArch: "0"
  property string totalAur: "0"
  property string totalText: "0"
  property bool debug: plasmoid.configuration.debugMode
  property bool separateResult: plasmoid.configuration.separateResult
  property string separator: plasmoid.configuration.separator
  property bool onUpdate: false

  anchors.fill: parent // the row fill the parent in height and width

  // updates the icon according to the refresh status
  function updateUi(refresh: boolean) {
    if (refresh) {
      updateIcon.source=iconRefresh
      totalText="↻"
    } else {
      updateIcon.source=iconUpdate
    }
  }

  // event handler for the left click on MouseArea
  function onLClick() {
    updater.countAll()
  }

  // event handler for the middle click on MouseArea
  function onMClick() {
    onUpdate = true
    updater.launchUpdate()
  }

  // return true if the taskbar is vertical
  function isBarVertical(): int {
    return row.width < row.height;
  }

  // generate the text for the count result
  function generateResult(): string {
    if (separateResult) {
      return totalArch + separator + totalAur
    } else {
      return `${parseInt(totalArch, 10) + parseInt(totalAur, 10)}`
    }
  }

  // map the cmd signal with the widget
  Connections {
    target: cmd

    function onConnected(source) {
      if (debug) console.log('ARCHUPDATE - cmd connected: ', source)
      updateUi(true)
    }

    function onExited(cmd, exitCode, exitStatus, stdout, stderr) {
      if (debug) console.log('ARCHUPDATE - cmd exited: ', JSON.stringify({cmd, exitCode, exitStatus, stdout, stderr}))

      // update the count after the update
      if (onUpdate || stdout === '') { // eg. the stdout is empty if the user close the update term with the x button
        onUpdate = false
        onLClick()
      }

      // handle the result for the count
      if (cmd === plasmoid.configuration.countArchCommand) {
        totalArch =  stdout.replace(/\n/g, '')
        generateResult()
      }
      if (cmd === plasmoid.configuration.countAurCommand) {
        totalAur =  stdout.replace(/\n/g, '')
        generateResult()
      }

      // handle the result for the checker
      if (cmd === "konsole -v") checker.validateKonsole(stderr)
      if (cmd === "checkupdates --version") checker.validateCheckupdates(stderr)

      updateUi(false)
    }
  }

  Item {
    id: container
    height: isBarVertical() ? row.width : row.height // usefull if the taskbar is vertical
    width: height

    Image {
      id: updateIcon
      height: container.height
      width: height
      Layout.fillWidth: true
      fillMode: Image.PreserveAspectFit
      // w/ the sourceSize set to the height the svg have alway the right definition
      sourceSize: Qt.size(height, height)
      source: iconUpdate
    }

    WorkspaceComponents.BadgeOverlay { // for the horizontal bar
      anchors {
        bottom: container.bottom
        horizontalCenter: container.right
      }
      visible: !isBarVertical()
      text: generateResult()
      icon: updateIcon
    }

    WorkspaceComponents.BadgeOverlay { // for the vertical bar
      anchors {
        verticalCenter: container.bottom
        right: container.right
      }
      visible: isBarVertical()
      text: totalText
      icon: updateIcon
    }

    MouseArea {
      anchors.fill: container // cover all the zone
      cursorShape: Qt.PointingHandCursor // give user feedback
      acceptedButtons: Qt.LeftButton | Qt.MiddleButton
      onClicked: (mouse) => {
        if (mouse.button == Qt.LeftButton) {
          onLClick()
        } else if (mouse.button == Qt.MiddleButton) {
          onMClick()
        }
      }
    }

  }
}
