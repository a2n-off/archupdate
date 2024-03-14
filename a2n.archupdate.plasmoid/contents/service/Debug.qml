import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.plasmoid

import org.kde.kirigami as Kirigami

Item {

    function log(message) {
        let date = Qt.formatTime(new Date(), "hh:mm:ss")
        let msg = '<font color="' + Kirigami.Theme.positiveTextColor + '">' + date + "</font>" + ' - ' + message + '<br/>'
        console.log(date + ' - ' + message)
        plasmoid.configuration.debugLog = plasmoid.configuration.debugLog + msg
    }

}
