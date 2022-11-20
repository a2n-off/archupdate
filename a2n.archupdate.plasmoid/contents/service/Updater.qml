import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15

import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.plasmoid 2.0

Item {

  property int interval: Plasmoid.configuration.updateInterval

  function count() {
    console.log(interval)
    cmd.exec("pacman -Sup | wc -l")
  }

  // execute function count each 30 minutes
  Timer {
    id: timer
    interval: interval * 60000 // minute to milisecond
    running: true
    repeat: true
    triggeredOnStart: true // trigger on start for a first checkind
    onTriggered: count()
  }

}
