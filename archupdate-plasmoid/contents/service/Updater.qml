import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15

import org.kde.plasma.core 2.0 as PlasmaCore

Item {

  property string output: "0"

  PlasmaCore.DataSource {
    id: executable
    engine: "executable"
    connectedSources: []
    onNewData: {
      var exitCode = data["exit code"]
      var exitStatus = data["exit status"]
      var stdout = data["stdout"]
      var stderr = data["stderr"]
      exited(sourceName, exitCode, exitStatus, stdout, stderr)
      disconnectSource(sourceName)
    }

    // execute the given cmd
    function exec(cmd: string) {
      if (cmd) {
        console.log('exec following cmd', cmd)
        connectSource(cmd)
      }
    }

    signal exited(string cmd, int exitCode, int exitStatus, string stdout, string stderr)
  }

  // map the stdout with the widget
  Connections {
    target: executable
    function onExited(cmd, exitCode, exitStatus, stdout, stderr) {
      output = stdout.replace(/\n/g, '')
      console.log(output)
    }
  }

  function count() {
    executable.exec("pacman -Sup | wc -l")
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
