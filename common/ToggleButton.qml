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
	signal rightClicked()

	Behavior on color {
		ColorAnimation {
			duration: 125
			easing.type: Easing.OutQuad
		}
	}

	MouseArea {
		id: mouseArea
		anchors.fill: parent 
		hoverEnabled: true 
		acceptedButtons: Qt.LeftButton | Qt.RightButton
		onClicked: (mouse) => onClickedHandler(mouse)

		function onClickedHandler(mouse) {
			if (mouse.button === Qt.LeftButton) {
				root.clicked()
				root.automaticallyToggle ? root.toggled = !root.toggled : null
			} else {
				root.rightClicked()
			}
		}
	}

	color: {
		if (toggled)
			return Colors.secondary
		else 
			return "transparent"
	}

	// Make foreground color available
	foregroundColor: {
		if (toggled) 
			return Colors._onSecondary
		else return Colors._onSurface
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
			easing.type: root.foregroundScale == 1.0 ? Easing.OutBack : Easing.OutQuad
		}
	}
}
