import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15

import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.plasmoid

PlasmoidItem {

  function konsole() {
    cmd.exec("konsole -v")
  }

  function checkupdates() {
    cmd.exec("checkupdates --version")
  }

  function validateKonsole(stderr) {
    configuration.konsoleIsValid = stderr === ''
    if (stderr !== '') cmd.exec("kdialog --passivepopup 'Missing dependency (konsole) for arch update plasmoid'")
  }

  function validateCheckupdates(stderr) {
    configuration.checkupdateIsValid = stderr === ''
    if (stderr !== '') cmd.exec("kdialog --passivepopup 'Missing dependency (pacman-contrib) for arch update plasmoid'")
  }

}
