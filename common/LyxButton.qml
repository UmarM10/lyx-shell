// import Quickshell
import QtQuick

import qs

Rectangle {
	id: root
	radius: 5
	color: backgroundColor

	implicitWidth: 30
	implicitHeight: 30

	Behavior on color {
		ColorAnimation {
			duration: 125
			easing.type: Easing.OutQuad
		}
	}
	Behavior on foregroundColor {
		ColorAnimation {
			duration: 125 
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
	property color backgroundColor: {
		if (mouseArea.containsPress)
			return Colors.topPrimary;
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
