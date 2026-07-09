import Quickshell
import Quickshell.Widgets
import Quickshell.Services.Notifications
import QtQuick 

import qs
import qs.common 
import qs.config

Rectangle {
	id: root
	implicitWidth: ListView.view ? ListView.view.width : 0
	implicitHeight: expanded ? 110 : 75
	color: Colors.surfaceContainerHighest

	Behavior on implicitHeight {
		NumberAnimation { 
			duration: 150 
			easing.type: Easing.OutBack
			easing.overshoot: 0.6
		}
	}

	property bool expanded: false

	property Notification notification

	property string cachedSummary: ""
	property string cachedBody: ""
	property var cachedImage: ""

	onNotificationChanged: {
		if (notification) {
			cachedSummary = notification.summary 
			cachedBody = notification.body 
			cachedImage = notification.image
		}
	}

	property bool topNotification: {
		ListView.view ? index === 0 ? true : false : true
	}
	property bool bottomNotification: {
		ListView.view ? index === (ListView.view.count - 1) ? true : false : true 
	}

	topLeftRadius: topNotification ? 20 : 5
	topRightRadius: topNotification ? 20 : 5 
	bottomLeftRadius: bottomNotification ? 20 : 5 
	bottomRightRadius: bottomNotification ? 20 : 5

	Behavior on topLeftRadius { NumberAnimation { duration: 100; easing.type: Easing.OutQuad } }
	Behavior on topRightRadius { NumberAnimation { duration: 100; easing.type: Easing.OutQuad } }
	Behavior on bottomLeftRadius { NumberAnimation { duration: 100; easing.type: Easing.OutQuad } }
	Behavior on bottomRightRadius { NumberAnimation { duration: 100; easing.type: Easing.OutQuad } }

	Row {
		anchors.top: parent.top 
		anchors.left: parent.left
		anchors.topMargin: 10
		anchors.leftMargin: 10
		spacing: 10

		ClippingWrapperRectangle {
			y: 3
			visible: root.cachedImage
			width: 31 
			height: 31 
			radius: 10
			Image {
				anchors.fill: parent
				source: root.cachedImage
				sourceSize.width: 31
				sourceSize.height: 31
			}
		}

		Column {
			LyxText {
				id: title 
				weightModifier: +100 
				usePercentSize: true 
				percentSize: 1.0 
				text: root.cachedSummary
				width: 220
				elide: Text.ElideRight
			}
			LyxText {
				id: body 
				weightModifier: -100 
				usePercentSize: true 
				percentSize: 0.9
				text: root.cachedBody
				width: 220 
				wrapMode: Text.Wrap
				maximumLineCount: root.expanded ? 4 : 2
				elide: Text.ElideRight

				// Rectangle {
				// 	anchors.fill: parent
				// 	color: "red"
				// 	opacity: 0.3
				// 	radius: 5
				// }
			}
		}
	}

	Row {
		id: notificationControlButtons
		anchors.right: parent.right
		anchors.rightMargin: 10
		anchors.verticalCenter: parent.verticalCenter 
		spacing: 2 

		LyxButton {
			implicitWidth: 25 
			implicitHeight: 25
			color: Colors.primary
			hoverColor: Colors._onPrimary
			hoverOpacity: 0.2

			topLeftRadius: Positioner.index === 0 ? 10 : 2
			bottomLeftRadius: topLeftRadius 
			topRightRadius: Positioner.index === parent.children.length - 1 ? 10 : 2
			bottomRightRadius: topRightRadius

			MaterialIcon {
				anchors.centerIn: parent
				width: 25; height: 25 
				iconId: "chevron-down.svg"
				color: Colors._onPrimary

				rotation: root.expanded ? 180 : 0
				Behavior on rotation { 
					NumberAnimation { 
						duration: 150
						easing.type: Easing.OutBack
						easing.overshoot: 0.6
					} 
				}
			}

			onClicked: root.expanded = !root.expanded
		}

		LyxButton {
			implicitWidth: 25 
			implicitHeight: 25
			color: Colors.primary
			hoverColor: Colors._onPrimary
			hoverOpacity: 0.2

			topLeftRadius: Positioner.index === 0 ? 10 : 3
			bottomLeftRadius: topLeftRadius 
			topRightRadius: Positioner.index === parent.children.length - 1 ? 10 : 3
			bottomRightRadius: topRightRadius

			MaterialIcon {
				anchors.centerIn: parent
				width: 19; height: 19 
				iconId: "close.svg"
				color: Colors._onPrimary
			}

			onClicked: root.notification.dismiss()
		}
	}

	Behavior on x {
		NumberAnimation {
			duration: 100 
			easing.type: Easing.OutBack
			easing.overshoot: 0.6
		}
	}
	
	MouseArea {
		id: dragArea
		anchors.fill: root
		hoverEnabled: false
		drag.target: root
		drag.maximumX: 10
		drag.axis: Drag.XAxis
		z: -1

		property int initialX 
		
		property int dismissThreshold: -150

		onPressed: {
			root.x = initialX
		}

		onReleased: {
			if (root.x <= dismissThreshold) {
				root.notification.dismiss()
			} else {
				root.x = initialX
			}
		}
	}

	
	SequentialAnimation {
		id: entranceAnimation 
		running: true
		
		NumberAnimation {
			target: root
			property: "scale"
			to: 0.8
			duration: 25
			easing.type: Easing.OutExpo
		}
		NumberAnimation {
			target: root
			property: "scale"
			to: 1.1
			duration: 100
			easing.type: Easing.OutBack
			easing.overshoot: 0.6
		}
		NumberAnimation {
			target: root 
			property: "scale"
			to: 1.0 
			duration: 100
			easing.type: Easing.OutBack
			easing.overshoot: 0.6
		}
	}
}
