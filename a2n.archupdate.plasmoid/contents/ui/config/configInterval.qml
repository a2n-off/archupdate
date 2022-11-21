/* Copyright (C) 2022  Bouteiller Alan - for more information check the LICENSE file at the root of the project */

import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15 as Controls
import org.kde.kirigami 2.19 as Kirigami

Kirigami.Page {

  id: intervalConfigPage

  property alias cfg_updateInterval: updateIntervalSpin.value

  ColumnLayout {
    anchors {
      left: parent.left
      top: parent.top
      right: parent.right
    }

    Kirigami.InlineMessage {
      Layout.fillWidth: true
      text: "You must have the pacman-contrib package installed for this widget to work. <a href=\"https://archlinux.org/packages/community/x86_64/pacman-contrib\">Download it here.<a/>"
      onLinkActivated: Qt.openUrlExternally(link)
      type: Kirigami.MessageType.Warning
      visible: true
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

    }

  }

}
