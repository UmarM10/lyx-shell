import Quickshell.Services.Pipewire
import Qt5Compat.GraphicalEffects
import QtQuick

import qs
import qs.common
import "js/volume_icon.js" as Logic

LyxButton {
    id: root
    anchors.horizontalCenter: parent.horizontalCenter
    implicitHeight: 25.5
    implicitWidth: 30

    Image {
        id: volumeIcon
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        height: 21
        width: 21
        sourceSize.width: 21
        sourceSize.height: 21

        // Animation
        LyxIconAnimation {
            id: iconSwapAnimation
            target: volumeIcon
        }

        onSourceChanged: {
            iconSwapAnimation.restart();
        }

        PwObjectTracker {
            objects: Pipewire.nodes.values
        }

        source: Logic.getAudioIconPath()

        ColorOverlay {
            anchors.fill: parent
            source: parent
            color: root.foregroundColor
        }
    }
}
