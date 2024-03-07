import QtQuick
import org.kde.plasma.configuration

ConfigModel {
    ConfigCategory {
         name: i18nc("@title", "Command & debug")
         icon: "preferences-other"
         source: "config/configCommand.qml"
    }
    ConfigCategory {
        name: i18nc("@title", "Display")
        icon: "preferences-other"
        source: "config/configDisplay.qml"
    }
    ConfigCategory {
        name: i18nc("@title", "Mouse action")
        icon: "preferences-other"
        source: "config/configMouse.qml"
    }
}
