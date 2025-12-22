import Quickshell.Hyprland
import QtQuick

import qs

Repeater {
	id: workspaces
	model: Hyprland.workspaces
	Rectangle {
		implicitWidth: 20
		implicitHeight: Hyprland.focusedWorkspace.id == modelData.id ? 63.5 : 17
		radius: 10

		// Workspace Colors
		gradient: Gradient {
			id: workspaceColor
			GradientStop {
				position: 0.0

				color: workspaceMouseArea.containsMouse ? Colors.primary : Hyprland.focusedWorkspace.id == modelData.id ? Colors.primaryDark : Colors.primaryContainer

				Behavior on color {
					ColorAnimation {
						duration: 150
						easing.type: Easing.OutQuad
					}
				}
			}
			GradientStop {
				position: 1.0

				color: workspaceMouseArea.containsMouse ? Colors.primary : Hyprland.focusedWorkspace.id == modelData.id ? Colors.primaryLight : Colors.primaryContainerVariant

				Behavior on color {
					ColorAnimation {
						duration: 150
						easing.type: Easing.OutQuad
					}
				}
			}
		}

		// Switching Animation
		Behavior on implicitHeight {
			NumberAnimation {
				duration: 200
				easing.type: Easing.OutQuad
			}
		}

		// Go to selected workspace
		MouseArea {
			id: workspaceMouseArea
			anchors.fill: parent
			hoverEnabled: true
			onClicked: Hyprland.dispatch("workspace " + modelData.id)
		}
	}
}
