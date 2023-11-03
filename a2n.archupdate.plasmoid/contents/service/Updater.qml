import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15

import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.plasmoid 2.0

Item {

  property int intervalConfig: Plasmoid.configuration.updateInterval
  property string countCommand: Plasmoid.configuration.countCommand
  property string updateCommand: Plasmoid.configuration.updateCommand
  property bool notCloseCommand: Plasmoid.configuration.notCloseCommand

  function count() {
    if (countCommand !== '') cmd.exec(countCommand)
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
    onTriggered: count()
  }

}
