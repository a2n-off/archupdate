import QtQuick
import org.kde.kirigami as Kirigami
import org.kde.ksvg as KSvg
import org.kde.plasma.workspace.components as WorkspaceComponents
import org.kde.plasma.plasmoid
import "."

Item {
    id: root

    property bool iconUseCustomColor: plasmoid.configuration.iconUseCustomColor
    property string iconColor: plasmoid.configuration.iconColor

    anchors.centerIn: parent
    property var source

    Kirigami.Icon {
        id: svgItem
        opacity: 1
        width: parent.width
        height: parent.height
        property int sourceIndex: 0
        anchors.centerIn: parent
        smooth: true
        isMask: true
        color: iconUseCustomColor ? iconColor : Kirigami.Theme.colorSet
        source: Qt.resolvedUrl("../../assets/" + root.source)
    }
}
