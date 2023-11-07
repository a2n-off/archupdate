import QtQuick 2.0
import QtQuick.Layouts 1.1
import org.kde.kirigami 2.20 as Kirigami
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 3.0 as PlasmaComponents3
import org.kde.plasma.extras 2.0 as PlasmaExtras
import org.kde.plasma.plasmoid 2.0

ColumnLayout {
    id: root;
    // property var usageNow;
    property var dividerColor: Kirigami.Theme.textColor
    property var dividerOpacity: 0.1
    property string totalArch: "0"
    property string totalAur: "0" 

    ColumnLayout {
        id: mainLayout;
        Layout.topMargin: PlasmaCore.Units.gridUnit / 2
        Layout.leftMargin: PlasmaCore.Units.gridUnit / 2
        Layout.bottomMargin: PlasmaCore.Units.gridUnit / 2
        Layout.rightMargin: PlasmaCore.Units.gridUnit / 2
        //Layout.preferredWidth: PlasmaCore.Units.gridUnit * 50

        PlasmaExtras.Heading {
            id: tooltipMaintext
            level: 3
            elide: Text.ElideRight
            text: Plasmoid.metaData.name
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
