import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15

import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.plasmoid

PlasmoidItem {

  property int intervalConfig: configuration.updateInterval
  property string countArchCommand: configuration.countArchCommand
  property string countAurCommand: configuration.countAurCommand
  property string updateCommand: configuration.updateCommand
  property bool notCloseCommand: configuration.notCloseCommand

  function countArch() {
    if (countArchCommand !== '') cmd.exec(countArchCommand)
  }

  function countAur() {
    if (countAurCommand !== '') cmd.exec(countAurCommand)
  }

  function countAll() {
    countArch()
    countAur()
  }

  function launchUpdate() {
    if (updateCommand !== '') {
      if (notCloseCommand) {
        cmd.exec("konsole --noclose -e '" + updateCommand + "'")
      } else {
        cmd.exec("konsole -e '" + updateCommand + "'")
      }
    }
  }

  function killProcess(process) {
    cmd.exec("kill -9 " + process)
  }

  // execute function count each 30 minutes
  Timer {
    id: timer
    interval: intervalConfig * 60000 // minute to milisecond
    running: true
    repeat: true
    triggeredOnStart: true // trigger on start for a first checkind
    onTriggered: countAll()
  }

}
