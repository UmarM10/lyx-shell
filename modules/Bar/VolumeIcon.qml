import Quickshell.Services.Pipewire
import Qt5Compat.GraphicalEffects
import QtQuick

import qs
import "js/volume_icon.js" as Logic

Rectangle {
    id: volumeIconBox
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
        SequentialAnimation {
            id: volumeIconAnimation
            NumberAnimation {
                target: volumeIcon
                property: "scale"
                to: 0.75
                duration: 75
                easing.type: Easing.OutQuad
            }

            PauseAnimation {
                duration: 50
            }

            NumberAnimation {
                target: volumeIcon
                property: "scale"
                to: 1.0
                duration: 100
                easing.type: Easing.OutQuad
            }
        }
        onSourceChanged: {
            volumeIconAnimation.restart();
        }

        PwObjectTracker {
            objects: Pipewire.nodes.values
        }
        
        source: Logic.getAudioIconPath()

        ColorOverlay {
            anchors.fill: parent
            source: parent
            color: Logic.getForegroundColor()
        }
    }

	signal volumePopupToggled()
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
		onClicked: volumePopupToggled()
    }

    radius: 4
    color: Logic.getBackgroundColor()
    Behavior on color {
        ColorAnimation {
            duration: 75
            easing.type: Easing.OutQuad
        }
    }
}
