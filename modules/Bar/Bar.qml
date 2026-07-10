import Quickshell
import Quickshell.Wayland
import QtQuick
import Qt5Compat.GraphicalEffects

import qs
import qs.common
import qs.config

Variants {
	model: Quickshell.screens

	property var controlCenter 
	property var sidebar

	delegate: PanelWindow {
		id: barPanel
		WlrLayershell.namespace: "lyx-bar"
		anchors {
			right: secondaryMonitor
			left: !secondaryMonitor
			top: true
			bottom: true
		}

		property var modelData
		screen: modelData
		property bool secondaryMonitor: modelData === Quickshell.screens[1]

		implicitWidth: 55
		color: "transparent"

		property var controlCenter: parent.controlCenter
		property var sidebar: parent.sidebar

		Rectangle {
			id: background
			color: Colors.surface
			opacity: Config.general.shellOpacity
			topLeftRadius: !barPanel.secondaryMonitor ? Config.general.screenCornerRounding * 1 : undefined
			bottomLeftRadius: !barPanel.secondaryMonitor ? Config.general.screenCornerRounding * 1 : undefined
			z: 0

			Behavior on color { ColorAnimation { duration: 500; easing.type: Easing.OutQuad } }

			anchors.horizontalCenter: parent.horizontalCenter
			anchors.verticalCenter: parent.verticalCenter
			anchors.fill: parent
		}

		// Virtual Rounded Screen
		Corner {
			visible: !barPanel.secondaryMonitor
			anchors.top: parent.top 
			anchors.left: parent.left 
			target: parent
			corner: "topLeft"
			radius: Config.general.screenCornerRounding
			color: "black"
		}
		Corner {
			visible: !barPanel.secondaryMonitor
			anchors.bottom: parent.bottom
			anchors.left: parent.left 
			target: parent
			corner: "bottomLeft"
			radius: Config.general.screenCornerRounding
			color: "black"
		}

		Column {
			id: startOfBar
			spacing: 5
			anchors {
				top: parent.top
				topMargin: 10
				horizontalCenter: parent.horizontalCenter
			}

			NotificationsIcon {}
			SystemTray {}
		}

		Column {
			id: centerOfBar
			anchors {
				centerIn: parent
				horizontalCenter: parent.horizontalCenter
			}
			spacing: 4.5

			Workspaces {}
		}

		Column {
			id: endOfBar
			anchors {
				bottom: parent.bottom
				bottomMargin: 10
				horizontalCenter: parent.horizontalCenter
			}
			spacing: 5

			TimeButton { sidebar: barPanel.sidebar }

			Separator { anchors.horizontalCenter: parent.horizontalCenter }

			ControlsSection { 
				id: controlsSection

				visible: !barPanel.secondaryMonitor

				controlCenter: barPanel.controlCenter 
				sidebar: barPanel.sidebar
			}	
		}
	}
}
