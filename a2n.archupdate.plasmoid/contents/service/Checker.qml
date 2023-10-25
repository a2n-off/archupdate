import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15

import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.plasmoid 2.0

Item {

  property bool checkPassedKonsole: false
  property bool checkPassedCheckupdates: false

  function konsole() {
    cmd.exec("konsole -v")
  }

  function checkupdates() {
    cmd.exec("checkupdates --version")
  }

  function validateKonsole() {
    checkPassedKonsole = true
  }

  function validateCheckupdates() {
    checkPassedCheckupdates = true
  }

}
