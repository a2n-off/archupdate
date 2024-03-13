import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as Controls

import org.kde.kirigami as Kirigami
import org.kde.plasma.components as PlasmaComponents

PlasmaComponents.ItemDelegate {
    id: listItem

    // index  = index of the element in the model
    // isArch = true if the cmd is the listArch command
    // name   = package name
    // fv     = from version
    // tv     = to version

    width: parent.width

    // generate & style the name of the package
    function generateName() {
        return name + '<font color="' + Kirigami.Theme.disabledTextColor + '"> from ' + (isArch ? 'arch' : 'aur') + '</font>'
    }

    // generate & style the version of the package
    function generateVersion() {
        return '<font color="' + Kirigami.Theme.negativeTextColor + '">' + fv + '</font> > <font color="' + Kirigami.Theme.positiveTextColor + '">' + tv + '</font>'
    }

    // Add MouseArea to detect mouse hover
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onEntered: listItem.highlighted = true
        onExited: listItem.highlighted = false
    }

    contentItem: ColumnLayout {
        spacing: 2

        Kirigami.Heading {
            id: itemHeading
            level: 3
            width: parent.width
            text: generateName()
        }

        Controls.Label {
            id: itemLabel
            width: parent.width
            wrapMode: Text.Wrap
            text: generateVersion()
        }
    }

    // separator
    Rectangle {
        id: headerSeparator
        anchors.bottom: parent.bottom
        width: parent.width
        height: 1
        color: Kirigami.Theme.textColor
        opacity: 0.25
        visible: true
    }

}
