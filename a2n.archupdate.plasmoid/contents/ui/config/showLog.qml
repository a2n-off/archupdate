import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as Controls
import org.kde.kirigami as Kirigami
import org.kde.kquickcontrols as KQuickControls
import org.kde.plasma.components as PlasmaComponents

Kirigami.ScrollablePage {

    id: debugConfigPage

    property alias cfg_debugLog: logWindow.text

    ColumnLayout {

        anchors {
            left: parent.left
            top: parent.top
            right: parent.right
        }

        Kirigami.FormLayout {
            wideMode: false

            Kirigami.Separator {
                Kirigami.FormData.isSection: true
                Kirigami.FormData.label: 'Debug log'
            }
        }

        Kirigami.FormLayout {
            ColumnLayout {
                PlasmaComponents.Button {
                    text: 'Clear log data (hit apply after)'
                    onClicked: logWindow.text = ''
                }

                Controls.Label {
                    id: logWindow
                    width: parent.width
                    wrapMode: Text.Wrap
                }
            }
        }

    }

}

