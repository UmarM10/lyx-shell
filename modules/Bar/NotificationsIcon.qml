import Qt5Compat.GraphicalEffects
import QtQuick

import qs.common
import "js/notifications_icon.js" as Logic

LyxButton {
    id: root
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
		LyxIconAnimation {
			id: iconSwapAnimation
			target: notificationsIcon
		}
        onSourceChanged: {
            iconSwapAnimation.restart();
        }
		source: "../../icons/bell-solid-full.svg"        

        ColorOverlay {
            anchors.fill: parent
            source: parent
            color: root.foregroundColor
        }
    }
}
