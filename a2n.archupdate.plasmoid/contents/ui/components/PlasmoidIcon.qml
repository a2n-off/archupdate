import QtQuick 2.15
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.workspace.components 2.0 as WorkspaceComponents
import "."

Item {
    id: root
    anchors.centerIn: parent
    property var source

    PlasmaCore.SvgItem {
        id: svgItem
        opacity: 1
        width: parent.width
        height: parent.height
        property int sourceIndex: 0
        anchors.centerIn: parent
        smooth: true
        svg: PlasmaCore.Svg {
            id: svg
            colorGroup: PlasmaCore.ColorScope.colorGroup
            imagePath: Qt.resolvedUrl("../../assets/" + source)
        }
    }

}
