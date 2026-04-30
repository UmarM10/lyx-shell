import Quickshell 
import Quickshell.Widgets
import Quickshell.Hyprland
import QtQuick 

import qs 
import qs.common 
import qs.config 

ClippingRectangle {
	id: root 
	anchors.bottom: parent.bottom
	anchors.horizontalCenter: parent.horizontalCenter
	implicitWidth: 675
	implicitHeight: 335 
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
		onPressed: root.toggle()
	}

	state: "invisible"
	states: [
		State {
			name: "invisible"
			PropertyChanges {
				root {
					implicitWidth: 0
					implicitHeight: 0 
					opacity: 0.0
				}
			}
		}, 
		State {
			name: "calendar"
		},
		State {
			name: "dash"
			PropertyChanges {
				root {
					implicitWidth: 675
					implicitHeight: 335 
					opacity: 1.0
				}
			}
		},
		State {
			name: "launcher"
		}, 
		State {
			name: "wallpapers"
		},
		State {
			name: "clocks"
		}
	]
	transitions: [
		Transition {
			NumberAnimation {
				properties: "implicitHeight"
				easing.type: Easing.OutExpo 
				duration: 300
			}
			OpacityAnimator {
				duration: 100
			}
		},
		Transition {
			to: "invisible"
			NumberAnimation {
				properties: "implicitHeight"
				easing.type: Easing.InExpo 
				duration: 30
			}
		}
	]
}
