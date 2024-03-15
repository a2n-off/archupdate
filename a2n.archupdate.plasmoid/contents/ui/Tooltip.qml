import QtQuick
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.components as PlasmaComponents3
import org.kde.plasma.extras as PlasmaExtras
import org.kde.plasma.plasmoid

ColumnLayout {
    id: root

    property var dividerColor: Kirigami.Theme.textColor
    property var dividerOpacity: 0.1
    property string totalArch: "0"
    property string totalAur: "0"

    function noUpdateAvailable() {
        return totalArch === "0" && totalAur === "0"
    }

    // map the cmd signal
    Connections {
        target: cmd

        function onTotalAur(total) {
            root.totalAur = total
        }

        function onTotalArch(total) {
            root.totalArch = total
        }
    }

    ColumnLayout {
        id: mainLayout;
        Layout.topMargin: Kirigami.Units.gridUnit / 2
        Layout.leftMargin: Kirigami.Units.gridUnit / 2
        Layout.bottomMargin: Kirigami.Units.gridUnit / 2
        Layout.rightMargin: Kirigami.Units.gridUnit / 2
        //Layout.preferredWidth: Kirigami.Units.gridUnit * 50

        PlasmaExtras.Heading {
            id: tooltipMaintext
            level: 3
            elide: Text.ElideRight
            text: noUpdateAvailable() ? "No updates available" : "Updates are available"
        }

        RowLayout {
            RowLayout {
                PlasmaComponents3.Label {
                    text: "Arch:"
                    opacity: 1
                }
                PlasmaComponents3.Label {
                    text: totalArch
                    opacity: .7
                }
            }
            Item { Layout.fillWidth: true }
            RowLayout {
                PlasmaComponents3.Label {
                    text: "AUR:"
                    opacity: 1
                }
                PlasmaComponents3.Label {
                    text: totalAur
                    opacity: .7
                }
            }
        }
    }
}
