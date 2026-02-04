// import Quickshell
import Quickshell.Widgets
import QtQuick 

import qs 
// import qs.common 
import qs.modules.ControlCenter

ClippingRectangle {
	id: root
	visible: false
	implicitWidth: 0	
	implicitHeight: 0
	anchors.bottom: parent.bottom
	anchors.bottomMargin: 10
	anchors.left: parent.left
	color: Colors.background
	opacity: 0.0
	topRightRadius: 15

	function show() { showAnimation.restart() }
	function hide() { hideAnimation.restart() }

	SequentialAnimation {
		id: showAnimation
		running: false

		PropertyAction { target: root; property: "implicitWidth"; value: 0 }
		PropertyAction { target: root; property: "implicitHeight"; value: 0 }
		PropertyAction { target: root; property: "visible"; value: true }
		ParallelAnimation {
			NumberAnimation {
				target: root
				property: "implicitWidth"
				to: 300
				duration: 200
				easing.type: Easing.OutCirc
			}
			NumberAnimation {
				target: root
				property: "implicitHeight"
				to: 450
				duration: 200
				easing.type: Easing.OutCirc
			}
			OpacityAnimator {
				target: root
				to: 1.0
				duration: 50
			}
		}
	}

	SequentialAnimation {
		id: hideAnimation

		ParallelAnimation {
			NumberAnimation {
				target: root
				property: "implicitWidth"
				to: 0
				duration: 300
				easing.type: Easing.OutQuad
			}
			NumberAnimation {
				target: root
				property: "implicitHeight"
				to: 0
				duration: 300
				easing.type: Easing.OutQuad
			}
			OpacityAnimator {
				target: root
				to: 0
				duration: 100
			}
		}
		PropertyAction {
			target: root
			property: "visible"
			value: false
		}
	}
	
	UserSection {}
}
