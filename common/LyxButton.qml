// import Quickshell
import QtQuick

import qs

Rectangle {
	id: root
	radius: 5
	color: getBackgroundColor()

	property color foregroundColor: getForegroundColor()

	Behavior on color {
		ColorAnimation {
			duration: 75
			easing.type: Easing.OutQuad
		}
	}
	signal clicked()
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
		onClicked: clicked()
    }

	// Get Background Color
	function getBackgroundColor() {
		if (mouseArea.containsPress)
			return Colors.primaryContainerVariant;
		if (mouseArea.containsMouse)
			return Colors.primary
		else
			return "transparent";
	}
	// Get Foreground Color
	function getForegroundColor() {
		if (mouseArea.containsMouse)
			return Colors.background;
		else
			return Colors.primary;
	}
}
