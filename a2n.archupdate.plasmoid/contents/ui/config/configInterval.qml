import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15 as Controls
import org.kde.kirigami 2.20 as Kirigami

Kirigami.Page {

  id: intervalConfigPage

  property alias cfg_updateInterval: updateIntervalSpin.value
  property alias cfg_debugMode: debugModeBox.checked

  ColumnLayout {
    anchors {
      left: parent.left
      top: parent.top
      right: parent.right
    }

    Kirigami.InlineMessage {
      Layout.fillWidth: true
      text: "You must have the <a href=\"https://archlinux.org/packages/extra/x86_64/konsole/\">konsole<a/> package installed for this widget to work."
      onLinkActivated: Qt.openUrlExternally(link)
      type: Kirigami.MessageType.Warning
      visible: true
    }

    Kirigami.InlineMessage {
      Layout.fillWidth: true
      text: "You must have the <a href=\"https://archlinux.org/packages/extra/x86_64/pacman-contrib/\">pacman-contrib<a/> package installed for this widget to work."
      onLinkActivated: Qt.openUrlExternally(link)
      type: Kirigami.MessageType.Warning
      visible: true
    }

    Kirigami.InlineMessage {
      Layout.fillWidth: true
      text: "This option enable some log in the stdout of plasma."
      visible: debugModeBox.checked
    }

    Kirigami.FormLayout {

      Controls.SpinBox {
        id: updateIntervalSpin
        Kirigami.FormData.label: "Update every: "
        from: 1
        to: 1440 // 1 day
        editable: true
        textFromValue: (value) => value + " minute(s)"
        valueFromText: (text) => parseInt(text)
      }

      Controls.CheckBox {
        id: debugModeBox
        Kirigami.FormData.label: "Debug: "
        checked: false
      }

    }

  }

}
