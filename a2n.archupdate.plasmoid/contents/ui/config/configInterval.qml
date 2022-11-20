import QtQuick 2.15
import QtQuick.Controls 2.15 as QtControls
import QtQuick.Layouts 1.15 as QtLayouts

import org.kde.kirigami 2.19 as Kirigami

Kirigami.FormLayout {
  id: intervalConfigPage

  property alias cfg_updateInterval: updateIntervalSpin.value

  QtControls.SpinBox {
    id: updateIntervalSpin
    Kirigami.FormData.label: "Update every: "
    from: 1
    to: 1440 // 1 day
    editable: true
    textFromValue: (value) => value + " minute(s)"
    valueFromText: (text) => parseInt(text)
  }


}
