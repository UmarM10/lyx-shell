import Quickshell.Services.Pipewire
import QtQuick

import qs.common
import "js/volume_icon.js" as Logic

LyxButton {
    id: root
    anchors.horizontalCenter: parent.horizontalCenter
    implicitHeight: 25.5
    implicitWidth: 30

    MaterialIcon {
        id: volumeIcon
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        height: 21
        width: 21
        color: root.foregroundColor

        PwObjectTracker {
            objects: Pipewire.nodes.values
        }

        iconId: Logic.getAudioIconPath()
    }
}
