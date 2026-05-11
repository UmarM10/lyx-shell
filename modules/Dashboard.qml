import Quickshell 
import Quickshell.Widgets
import Quickshell.Hyprland
import QtQuick 

import qs 
import qs.common 
import qs.modules.Dashboard
import qs.config 

ClippingRectangle {
	id: root 
	anchors.bottom: parent.bottom
	anchors.horizontalCenter: parent.horizontalCenter
	topLeftRadius: Config.values.cornerRounding 
	topRightRadius: topLeftRadius
	color: Colors.background

	property var dashboardPanel

	function show() { state = "dash" }
	function hide() { state = "invisible" }
	function toggle() { state === "invisible" ? state = "dash" : state = "invisible" }

	GlobalShortcut {
		name: "toggleDash"
		appid: "lyxShell"
		description: "Toggle Lyx Shell dashboard"
		onPressed: root.state !== "dash" ? root.state = "dash" : root.toggle()
	}
	GlobalShortcut {
		name: "toggleLauncher"
		appid: "lyxShell"
		description: "Toggle Lyx Shell launcher"
		onPressed: root.state !== "launcher" ? root.state = "launcher" : root.toggle()
	}

	DashboardTabs { dashboard: root }

	property int _currentWidth: 675
	onStateChanged: _currentWidth = root.implicitWidth
	implicitWidth: _currentWidth

	state: "invisible"
	states: [
		State {
			name: "invisible"
			PropertyChanges {
				root {
					implicitHeight: 0 
					opacity: 0.0
				}
			}
		}, 
		State {
			name: "clocks"
			PropertyChanges {
				root {
					implicitWidth: 700
					implicitHeight: 400
				}
			}
		},
		State {
			name: "calendar"
			PropertyChanges {
				root {
					implicitWidth: 700
					implicitHeight: 335
				}
			}
		},
		State {
			name: "dash"
			PropertyChanges {
				root {
					implicitWidth: 700
					implicitHeight: 335 
				}
			}
		},
		State {
			name: "launcher"
			PropertyChanges {
				root {
					implicitWidth: 550
					implicitHeight: 500
				}
			}
		}, 
		State {
			name: "wallpapers"
			PropertyChanges { 
				root {
					implicitWidth: 700
					implicitHeight: 335
				}
			}
		}
	]
	transitions: [
		Transition {
			NumberAnimation {
				properties: "implicitWidth,implicitHeight"
				easing.type: Easing.OutBack
				easing.overshoot: 0.55
				duration: 300
			}
			OpacityAnimator {
				duration: 100
			}
		},
		Transition {
			to: "invisible"
			NumberAnimation {
				properties: "implicitHeight,implicitWidth"
				easing.type: Easing.OutBack
				easing.overshoot: 0.55
				duration: 500
			}
			OpacityAnimator {
				duration: 250
			}
		}
	]
}
