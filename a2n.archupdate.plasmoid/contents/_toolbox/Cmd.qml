import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15

import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.plasma5support as Plasma5Support

Plasma5Support.DataSource {
  id: executable
  engine: "executable"
  connectedSources: []
  function onNewData(data) {
    var exitCode = data["exit code"]
    var exitStatus = data["exit status"]
    var stdout = data["stdout"]
    var stderr = data["stderr"]
    exited(sourceName, exitCode, exitStatus, stdout, stderr)
    disconnectSource(sourceName)
  }
  function onSourceConnected(source) {
    connected(source)
  }

  // execute the given cmd
  function exec(cmd: string) {
    if (cmd) connectSource(cmd)
  }

  signal connected(string source)
  signal exited(string cmd, int exitCode, int exitStatus, string stdout, string stderr)
}
