import Quickshell 
import Quickshell.Wayland
import QtQuick 
import QtQuick.Effects

import qs
import qs.common
import qs.config

PanelWindow {
	id: sidebarPanel

	property bool rightSidebar: false // If the sidebar should spawn from the right
	property string state: background.state
	function hide() { background.state = "hidden" }
	function show(section) { background.state = "" }
	function toggle(section) { background.state === "" ? hide() : show(section) }

	WlrLayershell.namespace: "lyx-sidebar"
	WlrLayershell.exclusiveZone: 0
	mask: Region { item: background }

	focusable: true

	anchors {
		top: true 
		left: true 
		bottom: true
	}

	implicitWidth: 450 
	visible: false
	color: "transparent"

	RectangularShadow {
		anchors.right: background.right
		anchors.verticalCenter: background.verticalCenter
		width: 10
		height: background.height - 25
		spread: 3
	}

	Corner {
		id: topCorner
		anchors.left: sidebarPanel.rightSidebar ? undefined : background.right 
		anchors.right: sidebarPanel.rightSidebar ? background.left : undefined
		anchors.top: background.top
		anchors.topMargin: 10
		corner: sidebarPanel.rightSidebar ? "topRight" : "topLeft"
		radius: 20
	}
	Corner {
		id: bottomCorner
		anchors.left: sidebarPanel.rightSidebar ? undefined : background.right 
		anchors.right: sidebarPanel.rightSidebar ? background.left : undefined 
		anchors.bottom: background.bottom 
		anchors.bottomMargin: 10 
		corner: sidebarPanel.rightSidebar ? "bottomRight" : "bottomLeft"
		radius: 20
	}
	
	Rectangle {
		id: background
		color: Colors.surface 
		width: sidebarPanel.width - 20
		height: sidebarPanel.height 
		topLeftRadius: Config.general.cornerRounding
		bottomLeftRadius: Config.general.cornerRounding

		Column {
			anchors.top: parent.top 
			anchors.left: parent.left
			anchors.topMargin: 10 
			spacing: 15
			width: parent.width - 20

			TopTime {}
			NotificationSection {}
		}

		state: "hidden"
		states: [
			State {
				name: "hidden"
				PropertyChanges {
					background {
						width: 0
						opacity: 0
					}
				}
			}
		]
		transitions: [
			Transition {
				from: "hidden"; to: ""
				SequentialAnimation {
					PropertyAction { 
						target: sidebarPanel 
						property: "visible"
						value: true
					}
					ParallelAnimation {
						NumberAnimation {
							property: "width"
							duration: 300
							easing.type: Easing.OutBack 
							easing.overshoot: 0.6
						}
						NumberAnimation {
							property: "opacity"
							easing.type: Easing.OutExpo
							duration: 200
						}
					}
				}
			},
			Transition {
				from: ""; to: "hidden"
				SequentialAnimation {
					ParallelAnimation {
						NumberAnimation {
							property: "width"
							duration: 300
							easing.type: Easing.OutBack 
							easing.overshoot: 0.6
						}
						NumberAnimation {
							property: "opacity"
							easing.type: Easing.OutExpo
							duration: 200
						}
					}
				}
			}
		]
	}
}
