import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as Controls

import org.kde.kirigami as Kirigami

import org.kde.plasma.plasmoid
import org.kde.plasma.extras as PlasmaExtras
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.components as PlasmaComponents

import "components" as Components

Item {
    focus: main.expanded
    anchors.fill: parent

    property string listAll: "dd"

    Layout.minimumHeight: 200
    Layout.maximumWidth: 200

    function update() {
        updater.launchUpdate()
    }

    function refresh() {
        updater.countAll()
    }

    // topbar
    RowLayout {
        id: header
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        width: parent.width

        RowLayout {
            Layout.alignment: Qt.AlignRight
            spacing: 0

            PlasmaComponents.ToolButton {
                id: updateIcon
                height: Kirigami.Units.iconSizes.medium
                icon.name: "install"
                onClicked: update()
                visible: main.hasUpdate()
            }

            PlasmaComponents.ToolButton {
                id: checkUpdatesIcon
                height: Kirigami.Units.iconSizes.medium
                icon.name: "view-refresh"
                onClicked: refresh()
            }
        }
    }

    // separator
    Rectangle {
        id: headerSeparator
        anchors.top: header.bottom
        width: parent.width
        height: 1
        color: Kirigami.Theme.textColor
        opacity: 0.25
        visible: true
    }

    // list of the package
    Kirigami.ScrollablePage {
        id: scrollView;

        background: Rectangle {
            anchors.fill: parent
            color: "transparent"
        }

        anchors.top: headerSeparator.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right

        ListView {
            id: packageView;
            anchors.rightMargin: Kirigami.Units.gridUnit
            clip: true
            model: ListModel {}
            currentIndex: -1;
            boundsBehavior: Flickable.StopAtBounds;
            focus: true
            delegate: ListModel {
                ListElement {
                    name: "Bill Smith"
                    number: "555 3264"
                }
                ListElement {
                    name: "John Brown"
                    number: "555 8426"
                }
                ListElement {
                    name: "Sam Wise"
                    number: "555 0473"
                }
            }
            onCountChanged: upToDateLabel.visible = !busyIndicator.visible && count == 0;
        }

    }

    // if not update is needed
    PlasmaExtras.PlaceholderMessage {
        id: upToDateLabel
        text: i18n("Nothing to do")
        anchors.centerIn: parent
        visible: false
    }

    // loading indicator
    PlasmaComponents.BusyIndicator {
        id: busyIndicator
        anchors.centerIn: parent
        visible: false
    }
}
