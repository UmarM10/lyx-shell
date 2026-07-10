// pragma ComponentBehavior: Bound

import Quickshell
import QtQuick 
import QtQuick.Controls

import qs
import qs.common 
import qs.services
import qs.config

import "submodules/"

Rectangle {
	id: root
	anchors.left: parent.left
	width: parent.width
	implicitHeight: 287
	color: Colors.surfaceContainer
	radius: Config.general.cornerRounding

	Rectangle {
		id: heading
		
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.top: parent.top 
		anchors.topMargin: 10

		implicitWidth: root.width - 20 
		implicitHeight: 25
		color: "transparent"

		LyxText {
			id: headingText
			anchors.left: parent.left 
			anchors.verticalCenter: parent.verticalCenter
			text: "Notification Center"
		}
		LyxButton {
			id: clearButton 
			anchors.right: parent.right 
			anchors.verticalCenter: parent.verticalCenter 
			implicitWidth: hovered ? 82 : 30
			implicitHeight: 30 
			radius: 30

			Behavior on implicitWidth { NumberAnimation { duration: 100; easing.type: Easing.OutQuad } }

			Row {
				anchors.centerIn: parent
				anchors.horizontalCenterOffset: -2
				scale: parent.foregroundScale

				MaterialIcon {
					anchors.verticalCenter: parent.verticalCenter
					iconId: "close.svg"
					width: 21 
					height: 21
					asynchronous: false
					color: Colors._onSurface
				}
				LyxText {
					anchors.verticalCenter: parent.verticalCenter
					usePercentSize: true 
					percentSize: 0.85
					visible: clearButton.hovered
					text: "Clear All"
				}
			}

			Timer {
				id: clearWaitTimer 
				interval: 100
			}
			onClicked: {
				const model = Notifications.server.trackedNotifications.values;

				for (let i = model.length - 1; i >= 0; i--) {
					model[i].dismiss();
					clearWaitTimer.restart();
				}
			}
		}
	}

	ListView {
		id: notificationListView 

		anchors.top: parent.top
		anchors.topMargin: heading.height + 20
		anchors.horizontalCenter: parent.horizontalCenter

		implicitWidth: root.width - 20
		implicitHeight: root.height - 48 
		
		orientation: ListView.Vertical
		spacing: 3
		bottomMargin: 10
		model: Notifications.server.trackedNotifications
		clip: true
		delegate: Notification {
			id: notificationDelegate
			notification: modelData
			dragDismissed: false
		}

		
		ScrollBar.vertical: scrollBar

		remove: Transition {
			NumberAnimation {
				properties: "x" 
				to: -400
				duration: 150
				easing.type: Easing.InExpo
			}
		}
		displaced: Transition {
			SequentialAnimation {
				PauseAnimation {
					duration: 135
				}
				NumberAnimation {
					properties: "y"
					duration: 150 
					easing.type: Easing.OutBack 
					easing.overshoot: 0.6
				}
			}
		}
	}

	ScrollBar {
		id: scrollBar
		anchors.left: notificationListView.right
		anchors.leftMargin: 10
		anchors.top: notificationListView.top
		height: notificationListView.height
	}
}
