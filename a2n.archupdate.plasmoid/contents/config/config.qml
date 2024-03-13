import QtQuick
import org.kde.plasma.configuration

ConfigModel {
    ConfigCategory {
         name: i18nc("@title", "Command & debug")
         icon: "applications-development-relative"
         source: "config/configCommand.qml"
    }
    ConfigCategory {
        name: i18nc("@title", "Display")
        icon: "computer-relative"
        source: "config/configDisplay.qml"
    }
    ConfigCategory {
        name: i18nc("@title", "Popup")
        icon: "input-touchscreen-relative"
        source: "config/configPopup.qml"
    }
    ConfigCategory {
        name: i18nc("@title", "Mouse action")
        icon: "input-mouse-relative"
        source: "config/configMouse.qml"
    }
}
