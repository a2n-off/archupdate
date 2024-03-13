import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as Controls
import org.kde.kirigami as Kirigami
import org.kde.kquickcontrols as KQuickControls

Kirigami.ScrollablePage {

    id: popupConfigPage

    property alias cfg_nameUseCustomColor: nameUseCustomColor.checked
    property alias cfg_nameColor: nameColor.color

    property alias cfg_sourceUseCustomColor: sourceUseCustomColor.checked
    property alias cfg_sourceColor: sourceColor.color

    property alias cfg_fvUseCustomColor: fvUseCustomColor.checked
    property alias cfg_fvColor: fvColor.color

    property alias cfg_separatorUseCustomColor: separatorUseCustomColor.checked
    property alias cfg_separatorColor: separatorColor.color
    property alias cfg_separatorText: separatorText.text

    property alias cfg_tvUseCustomColor: tvUseCustomColor.checked
    property alias cfg_tvColor: tvColor.color

    // generate & style the name of the package
    function generateName() {
        const nc = cfg_nameUseCustomColor ? cfg_nameColor : Kirigami.Theme.textColor
        const sc = cfg_sourceUseCustomColor ? cfg_sourceColor : Kirigami.Theme.disabledTextColor
        return '<font color="' + nc + '"> PackageName </font><font color="' + sc + '"> from source</font>'
    }

    // generate & style the version of the package
    function generateVersion() {
        const fvc = cfg_fvUseCustomColor ? cfg_fvColor : Kirigami.Theme.negativeTextColor
        const sc = cfg_separatorUseCustomColor ? cfg_separatorColor : Kirigami.Theme.textColor
        const tvc = cfg_tvUseCustomColor ? cfg_tvColor : Kirigami.Theme.positiveTextColor
        return '<font color="' + fvc + '">1.0.0</font><font color="' + sc + '"> ' + cfg_separatorText + ' </font><font color="' + tvc + '">2.0.0</font>'
    }

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
                Kirigami.FormData.label: "Popup color"
            }
        }

        Kirigami.FormLayout {
            ColumnLayout {
                spacing: 2

                Kirigami.Heading {
                    level: 3
                    width: parent.width
                    text: generateName()
                }

                Controls.Label {
                    width: parent.width
                    wrapMode: Text.Wrap
                    text: generateVersion()
                }
            }
        }

        Kirigami.FormLayout {
            RowLayout {
                Kirigami.FormData.label: "Custom name color: "
                Controls.CheckBox {
                    id: nameUseCustomColor
                    checked: cfg_nameUseCustomColor
                }
                KQuickControls.ColorButton {
                    id: nameColor
                    enabled: nameUseCustomColor.checked
                }
            }

            RowLayout {
                Kirigami.FormData.label: "Custom source color: "
                Controls.CheckBox {
                    id: sourceUseCustomColor
                    checked: cfg_sourceUseCustomColor
                }
                KQuickControls.ColorButton {
                    id: sourceColor
                    enabled: sourceUseCustomColor.checked
                }
            }

            RowLayout {
                Kirigami.FormData.label: "Custom 'from version' color: "
                Controls.CheckBox {
                    id: fvUseCustomColor
                    checked: cfg_fvUseCustomColor
                }
                KQuickControls.ColorButton {
                    id: fvColor
                    enabled: fvUseCustomColor.checked
                }
            }

            RowLayout {
                Kirigami.FormData.label: "Custom separator color: "
                Controls.CheckBox {
                    id: separatorUseCustomColor
                    checked: cfg_separatorUseCustomColor
                }
                KQuickControls.ColorButton {
                    id: separatorColor
                    enabled: separatorUseCustomColor.checked
                }
            }
            RowLayout {
                Controls.TextField {
                    id: separatorText
                    Kirigami.FormData.label: "Separator: "
                }
            }

            RowLayout {
                Kirigami.FormData.label: "Custom 'to version' color: "
                Controls.CheckBox {
                    id: tvUseCustomColor
                    checked: cfg_tvUseCustomColor
                }
                KQuickControls.ColorButton {
                    id: tvColor
                    enabled: tvUseCustomColor.checked
                }
            }

        }
    }
}
