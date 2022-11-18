import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import "../_toolbox" as Tb

Item {
  // toolbox import
  Tb.Delay { id: delay }

  function count(callback: Function) {
    delay.exec(2, () => callback("150"))
  }
}
