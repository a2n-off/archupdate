/* Copyright (C) 2022  Bouteiller Alan - for more information check the LICENSE file at the root of the project */

import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15

Item {

  Timer { id: sleeper }

  function exec(time, callback) {
    sleeper.interval = time * 1000; // ms to s
    sleeper.repeat = false;
    sleeper.triggered.connect(callback);
    sleeper.start();
  }
}
