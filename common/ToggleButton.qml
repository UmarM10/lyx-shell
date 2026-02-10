import Quickshell 
import QtQuick 

import qs 

Rectangle {
	id: root
	radius: 5 

	property bool toggled
	property bool automaticallyToggle: true
	property color foregroundColor 
	property real foregroundScale

	signal clicked() 

	Behavior on color {
		ColorAnimation {
			duration: 75 
			easing.type: Easing.OutQuad
		}
	}

	MouseArea {
		id: mouseArea
		anchors.fill: parent 
		hoverEnabled: true 
		onClicked: {
			root.clicked()
			root.automaticallyToggle ? root.toggled = !root.toggled : null
		}
	}

	color: {
		if (mouseArea.containsPress)
			return Colors.primaryContainerVariant
		else if (toggled)
			return Colors.primary
		else if (mouseArea.containsMouse)
			return Colors.primaryContainer
		else 
			return "transparent"
	}

	// Make foreground color available
	foregroundColor: {
		if (mouseArea.containsPress)
			return Colors.primary
		if (toggled) 
			return Colors.background
		else
			return Colors.primary;
	}

	// Make foreground scale available
	foregroundScale: {
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
