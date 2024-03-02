import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.plasma5support as Plasma5Support

Plasma5Support.DataSource {
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
