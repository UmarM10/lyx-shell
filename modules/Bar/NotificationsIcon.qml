import Quickshell.Services.Pipewire
import Qt5Compat.GraphicalEffects
import QtQuick

import qs
import "js/notifications_icon.js" as Logic
import "js/bar_icon.js" as BarIconLogic

Rectangle {
    id: volumeIconBox
    anchors.horizontalCenter: parent.horizontalCenter
    implicitHeight: 25.5
    implicitWidth: 30

    Image {
        id: notificationsIcon 
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        height: 21
        width: 21
        sourceSize.width: 21
        sourceSize.height: 21

        // Animation
        SequentialAnimation {
            id: notificationsIconAnimation
            NumberAnimation {
                target: notificationsIcon
                property: "scale"
                to: 0.75
                duration: 75
                easing.type: Easing.OutQuad
            }

            PauseAnimation {
                duration: 50
            }

            NumberAnimation {
                target: notificationsIcon
                property: "scale"
                to: 1.0
                duration: 100
                easing.type: Easing.OutQuad
            }
        }
        onSourceChanged: {
            notificationsIconAnimation.restart();
        }

		source: "../../icons/bell-solid-full.svg"        

        ColorOverlay {
            anchors.fill: parent
            source: parent
            color: BarIconLogic.getForegroundColor()
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
    }

    radius: 4
    color: BarIconLogic.getBackgroundColor()
    Behavior on color {
        ColorAnimation {
            duration: 75
            easing.type: Easing.OutQuad
        }
    }
}
