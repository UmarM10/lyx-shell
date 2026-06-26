// import Quickshell
import QtQuick

import qs
import qs.config

Rectangle {
	id: root
	radius: Config.general.cornerRounding * 0.4
	color: "transparent"

	property alias mouseArea: mouseArea 
	readonly property bool hovered: mouseArea.containsMouse 
	readonly property bool down: mouseArea.containsPress

	// Settable 
	property color hoverColor: Colors._onSurfaceVariant
	property real hoverOpacity: 0.08

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
	// readonly property color backgroundColor: {
	// 	if (mouseArea.containsMouse)
	// 		return Colors.primary;
	// 	else
	// 		return "transparent";
	// }

	Rectangle {
		id: colorOverlay 
		radius: root.radius
		anchors.fill: root
		opacity: mouseArea.containsMouse ? 0.08 : 0.0
		color: root.hoverColor

		Behavior on opacity { OpacityAnimator { duration: 125; easing.type: Easing.OutQuad} }
	}

	// Make foreground color available
	property color foregroundColor: {
		if (mouseArea.containsMouse)
			return Colors._onSurface;
		else 
			return Colors._onSurface;
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
			easing.type: root.foregroundScale == 1.0 ? Easing.OutBack : Easing.OutBack
		}
	}
}
