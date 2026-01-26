import Quickshell
import QtQuick

import qs
// import qs.modules.ControlCenter

PopupWindow {
	id: root
	visible: false
	color: "transparent"
	implicitWidth: 300
	implicitHeight: 450
	anchor.window: rootPanel
	anchor.rect.x: 60
	anchor.rect.y: 585

	onVisibleChanged: {
		showAnimation.restart()
	}

	Rectangle {
		id: background
		// anchors.fill: parent
		implicitWidth: 300
		implicitHeight: 50
		anchors.bottom: parent.bottom
		color: Colors.background
		radius: 20

		SequentialAnimation {
			id: showAnimation
			running: false
			PropertyAction { target: background; property: "implicitHeight"; value: 50 }
			NumberAnimation { target: background; property: "implicitHeight"; to: 450; duration: 250; easing.type: Easing.OutCubic }
		}
		SequentialAnimation {
			id: hideAnimation
			NumberAnimation { target: background; property: "implicitHeight"; to: 50; duration: 250; easing.type: Easing.OutCubic }
			PropertyAction { target: root; property: "visible"; value: "false" }
		}
	}
}
