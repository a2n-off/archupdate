import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15

import org.kde.plasma.core 2.0 as PlasmaCore

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
  onSourceConnected: {
    connected(source)
  }

  // execute the given cmd
  function exec(cmd: string) {
    if (cmd) connectSource(cmd)
  }

  signal connected(string source)
  signal exited(string cmd, int exitCode, int exitStatus, string stdout, string stderr)
}
