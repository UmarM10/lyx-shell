// import Quickshell
import QtQuick

import qs

Rectangle {
	id: root
	radius: 5

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
		onClicked: root.clicked()
    }

	// Set Background Color
	color: {
		if (mouseArea.containsPress)
			return Colors.primaryContainerVariant;
		else if (mouseArea.containsMouse)
			return Colors.primary;
		else
			return "transparent";
	}

	// Make foreground color available
	property color foregroundColor: {
		if (mouseArea.containsPress)
			return Colors.primary;
		else if (mouseArea.containsMouse)
			return Colors.background;
		else 
			return Colors.primary;
	}

	// Make foreground scale available
	property real foregroundScale: {
		if (mouseArea.containsPress)
			return 0.75
		else 
			return 1.0
	}
	Behavior on foregroundScale {
		NumberAnimation {
			duration: root.foregroundScale == 1.0 ? 150 : 200
			easing.type: root.foregroundScale == 1.0 ? Easing.OutExpo : Easing.OutQuad
		}
	}
}
