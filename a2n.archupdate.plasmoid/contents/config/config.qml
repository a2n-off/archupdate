/* Copyright (C) 2022  Bouteiller Alan - for more information check the LICENSE file at the root of the project */

import QtQuick 2.15

import org.kde.plasma.configuration 2.0

ConfigModel {
    ConfigCategory {
         name: i18nc("@title", "Interval configuration")
         icon: "preferences-other"
         source: "config/configInterval.qml"
    }
}
