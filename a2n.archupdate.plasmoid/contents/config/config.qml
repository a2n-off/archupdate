import QtQuick
import org.kde.plasma.configuration

ConfigModel {
    ConfigCategory {
         name: i18nc("@title", "Command & debug")
         icon: "applications-development"
         source: "config/configCommand.qml"
    }
    ConfigCategory {
        name: i18nc("@title", "Display")
        icon: "computer"
        source: "config/configDisplay.qml"
    }
    ConfigCategory {
        name: i18nc("@title", "Mouse action")
        icon: "input-mouse"
        source: "config/configMouse.qml"
    }
}
