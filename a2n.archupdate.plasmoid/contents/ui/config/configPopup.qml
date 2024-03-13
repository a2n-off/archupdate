import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as Controls
import org.kde.kirigami as Kirigami
import org.kde.kquickcontrols as KQuickControls

Kirigami.ScrollablePage {

    id: popupConfigPage

    property alias cfg_separateResult: separateResult.checked
    property alias cfg_separator: separator.text

    property alias cfg_dot: dot.checked
    property alias cfg_dotColor: dotColor.color
    property alias cfg_dotUseCustomColor: dotUseCustomColor.checked

    property alias cfg_iconColor: iconColor.color
    property alias cfg_iconUseCustomColor: iconUseCustomColor.checked

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
                Kirigami.FormData.label: "Icon"
            }
        }

        Kirigami.FormLayout {
            RowLayout {
                Kirigami.FormData.label: "Custom icon color: "
                visible: true
                Controls.CheckBox {
                    id: iconUseCustomColor
                    checked: false
                }

                KQuickControls.ColorButton {
                    id: iconColor
                    enabled: iconUseCustomColor.checked
                }
            }

        }

        Kirigami.FormLayout {
            wideMode: false

            Kirigami.Separator {
                Kirigami.FormData.isSection: true
                Kirigami.FormData.label: "Display"
            }
        }

        Kirigami.InlineMessage {
            Layout.fillWidth: true
            text: "The dot is shown only if update is needed.\nThis is the recommended option if you want to use the widget in your system tray or if you tend to have a lot of update that the label can't handle."
            visible: true
        }

        Kirigami.FormLayout {
            Controls.CheckBox {
                id: dot
                Kirigami.FormData.label: "Show a dot in place of the label: "
                checked: false
            }

            RowLayout {
                Kirigami.FormData.label: "Custom dot color: "
                visible: dot.checked
                Controls.CheckBox {
                    id: dotUseCustomColor
                    checked: false
                }

                KQuickControls.ColorButton {
                    id: dotColor
                    enabled: dotUseCustomColor.checked
                }
            }

        }

        Kirigami.FormLayout {
            wideMode: false

            Kirigami.Separator {
                Kirigami.FormData.isSection: true
                Kirigami.FormData.label: "Label display"
            }
        }

        Kirigami.InlineMessage {
            Layout.fillWidth: true
            text: "Expected result: arch + seprator + aur"
            visible: true
        }

        Kirigami.FormLayout {
            Controls.CheckBox {
                id: separateResult
                Kirigami.FormData.label: "Separate result: "
                checked: false
            }

            Controls.TextField {
                id: separator
                Kirigami.FormData.label: "Separator: "
                visible: separateResult.checked
            }

        }



    }

}
