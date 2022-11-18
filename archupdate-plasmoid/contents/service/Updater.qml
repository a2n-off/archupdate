import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15

import "../_toolbox" as Tb

Item {
  Tb.Cmd { id: cmd }

  // TODO update the db w/ pkexec or fakeroot
  // TODO executable.exec("echo -e 'no\n' | sudo pacman -Syu")
  function count() {
    console.log("counting")
    cmd.exec("pacman -Sup | wc -l")
  }
}
