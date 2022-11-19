import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15

import org.kde.plasma.core 2.0 as PlasmaCore

Item {

  function count() {
    cmd.exec("pacman -Sup | wc -l")
  }

  // execute function count each 30 minutes
  Timer {
    id: timer
    interval: 1800000 // ms
    running: true
    repeat: true
    triggeredOnStart: true // trigger on start for a first checkind
    onTriggered: count()
  }

}
