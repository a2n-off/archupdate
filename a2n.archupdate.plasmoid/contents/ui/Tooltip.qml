import QtQuick 2.0
import QtQuick.Layouts 1.1
import org.kde.kirigami as Kirigami
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.components as PlasmaComponents3
import org.kde.plasma.extras as PlasmaExtras
import org.kde.plasma.plasmoid

ColumnLayout {
    id: root;
    // property var usageNow;
    property var dividerColor: Kirigami.Theme.textColor
    property var dividerOpacity: 0.1
    property string totalArch: row.totalArch
    property string totalAur: row.totalAur

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
