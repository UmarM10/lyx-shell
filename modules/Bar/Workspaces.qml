import Quickshell.Hyprland
import QtQuick

import qs
import qs.common

Repeater {
	model: Hyprland.workspaces
	Rectangle {
		id: root
		property bool focusedWorkspace: {
			if (Hyprland.focusedWorkspace.id === modelData.id) {
				return true
			} else return false
		} 

		implicitWidth: 20
		implicitHeight: focusedWorkspace ? 63.5 : 17
		radius: 10

		border.width: 1
		border.color: Colors.outline

		Rectangle {
			id: colorOverlay 
			anchors.fill: parent 
			opacity: mouseArea.containsMouse ? 0.08 : 0.0
			radius: parent.radius
			color: root.focusedWorkspace ? Colors._onPrimary : Colors._onSurface

			Behavior on opacity { OpacityAnimator { duration: 150; easing.type: Easing.OutQuad } }
		}

		LyxText {
			id: label
			anchors.centerIn: parent
			color: {
				if (root.focusedWorkspace) {
					return Colors._onPrimary
				} else return Colors._onSurfaceVariant
			}
			text: modelData.id.toString()
			weightModifier: -200
			font.pixelSize: 12
			opacity: 0.0

			Behavior on opacity { OpacityAnimator { duration: 500 } }
		}

		onFocusedWorkspaceChanged: {
			if (focusedWorkspace) {
				label.opacity = 1.0;
				labelHideTimer.restart();
			}
		}

		Timer {
			id: labelHideTimer
			interval: 1000
			onTriggered: label.opacity = 0.0
		}

		// Workspace Colors
		color: {
			if (root.focusedWorkspace) {
				return Colors.primary
			} else {
				return Colors.surfaceContainerHighest
			}
		}
		Behavior on color { ColorAnimation { duration: 150; easing.type: Easing.OutQuad } }

		// Legacy Gradient
		// 
		// gradient: Gradient {
		// 	id: workspaceColor
		// 	GradientStop {
		// 		position: 0.0
		//
		// 		color: {
		// 			if (root.focusedWorkspace) {
		// 				return Colors.primaryContainer
		// 			} else {
		// 				return Colors.surfaceContainerHighest
		// 			}
		// 		}
		//
		// 		Behavior on color {
		// 			ColorAnimation {
		// 				duration: 150
		// 				easing.type: Easing.OutQuad
		// 			}
		// 		}
		// 	}
		// 	GradientStop {
		// 		position: 1.0
		//
		// 		color: {
		// 			if (root.focusedWorkspace) {
		// 				return Colors.primaryContainer
		// 			} else {
		// 				return Colors.surfaceContainerHighest
		// 			}
		// 		}
		//
		// 		Behavior on color {
		// 			ColorAnimation {
		// 				duration: 150
		// 				easing.type: Easing.OutQuad
		// 			}
		// 		}
		// 	}
		// }

		// Switching Animation
		Behavior on implicitHeight {
			NumberAnimation {
				duration: 250
				easing.type: Easing.OutQuad
			}
		}

		// Go to selected workspace
		MouseArea {
			id: mouseArea
			anchors.fill: parent
			hoverEnabled: true
			onClicked: !(root.focusedWorkspace) ? Hyprland.dispatch("workspace " + modelData.id) : null
		}
	}
}
