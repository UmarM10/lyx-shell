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
	implicitHeight: content.height + 25
	color: Colors.surfaceContainerHigh

	Behavior on implicitHeight {
		NumberAnimation { 
			duration: 150 
			easing.type: Easing.OutBack
			easing.overshoot: 0.9
		}
	}

	property bool expanded: false

	property bool dragDismissed: false

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
			id: content
			spacing: 10
			Column {
				LyxText {
					id: title 
					weightModifier: +100 
					usePercentSize: true 
					percentSize: 1.0 
					text: root.cachedSummary
					width: 265
					elide: Text.ElideRight
				}
				LyxText {
					id: body 
					weightModifier: -100 
					usePercentSize: true 
					percentSize: 0.9
					text: root.cachedBody
					width: 270
					wrapMode: Text.Wrap
					maximumLineCount: root.expanded ? 4 : 2
					elide: Text.ElideRight
				}
			}

			Row {
				id: buttonActionPillButtons
				visible: root.expanded
				spacing: 3

				property int buttonsTotalWidth: 270
				property int buttonHeight: 25
				
				Repeater {
					model: root.notification ? root.notification.actions : undefined
					delegate: LyxButton {
						id: actionButton

						implicitWidth: buttonActionPillButtons.buttonsTotalWidth / root.notification.actions.length
						implicitHeight: buttonActionPillButtons.buttonHeight

						property bool leftButton: Positioner.index === 0 && (parent.children.length >= 3)
						property bool rightButton: Positioner.index === (parent.children.length - 2) && Positioner.index != 0
						property bool singleButton: !leftButton && !rightButton && Positioner.index === 0

						topLeftRadius: !singleButton ? leftButton ? 20 : 2 : 20
						bottomLeftRadius: topLeftRadius 

						topRightRadius: !singleButton ? rightButton ? 20 : 2 : 20
						bottomRightRadius: topRightRadius

						color: Colors.primary
						hoverColor: Colors._onPrimary

						onVisibleChanged: {
							if (visible) {
								opacity = 0;
								showAnimation.restart();
							}
						}

						OpacityAnimator {
							id: showAnimation
							to: 1.0 
							duration: 100
							target: actionButton
						}

						LyxText {
							anchors.centerIn: parent
							color: Colors._onPrimary
							text: modelData.text
							usePercentSize: true
							percentSize: 0.9
							horizontalAlignment: Text.AlignHCenter
							width: parent.width - 6
							elide: Text.ElideRight
						}

						onClicked: modelData.invoke()
					}
				}
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
			color: Colors.surfaceContainerHighest
			hoverColor: Colors._onSurface
			
			topLeftRadius: Positioner.index === 0 ? 10 : 2
			bottomLeftRadius: topLeftRadius 

			// I made all this logic and pivoted to hardcode it cause realistically its probably only going 
			// to be two buttons here.
			topRightRadius: parent.children[1].visible ? 2 : 10
			bottomRightRadius: topRightRadius

			MaterialIcon {
				anchors.centerIn: parent
				width: 25; height: 25 
				iconId: "chevron-down.svg"
				color: Colors._onSurface

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
			color: root.expanded ? Colors.secondary : Colors.primary
			hoverColor: root.expanded ? Colors._onSecondary : Colors._onPrimary

			visible: root.notification ? root.notification.actions.length === 1 ? true : false : false
			
			topLeftRadius: Positioner.index === 0 ? 10 : 2
			bottomLeftRadius: topLeftRadius 
			topRightRadius: Positioner.index === parent.children.length - 1 ? 10 : 2
			bottomRightRadius: topRightRadius

			MaterialIcon {
				anchors.centerIn: parent
				width: 19; height: 19 
				iconId: "launch.svg"
				color: root.expanded ? Colors._onSecondary : Colors._onPrimary
			}

			onClicked: root.notification.actions[0].invoke()
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
		acceptedButtons: Qt.LeftButton | Qt.MiddleButton
		drag.target: root
		drag.maximumX: 10
		drag.axis: Drag.XAxis
		z: -1

		onClicked: (mouse) => {
			mouse.button === Qt.MiddleButton ? root.notification.dismiss() : null;
			mouse.button === Qt.LeftButton ? root.expanded = !root.expanded : null;
		}

		property int initialX 
		
		property int dismissThreshold: -150

		onPressed: {
			root.x = initialX;
		}

		onReleased: {
			if (root.x <= dismissThreshold) {
				root.dragDismissed = true;
				root.notification.dismiss();
			} else {
				root.x = initialX;
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
