import QtQuick 
import qs 

Rectangle {
	id: root

    property bool draggable: false
	property bool updateImmediately: true
	property var displayValue: 0.0
	property int sliderHeadWidth: 8
	signal valueUpdatedByDragging(real newValue)

	anchors.verticalCenter: parent.verticalCenter
	anchors.right: parent.right
	anchors.rightMargin: 1
	implicitWidth: parent.width - 32
	implicitHeight: 15
	color: Colors.primaryContainerVariant
	radius: 5

	Rectangle {
		id: leftActiveTrack
		anchors.right: trackHead.horizontalCenter
		anchors.left: root.left
		color: Colors.primaryContainer
		implicitWidth: root.width - (root.displayValue * root.width)
		implicitHeight: root.implicitHeight
		radius: 5
	}

	Rectangle {
		id: trackHead
		anchors.verticalCenter: parent.verticalCenter
		implicitWidth: root.sliderHeadWidth
		implicitHeight: 1.55 * root.height
		color: Colors.primary
		radius: 3

		x: (root.displayValue * root.width) - (trackHead.width / 2)
		Behavior on x {
			enabled: !dragArea.drag.active
			NumberAnimation {
				easing.type: Easing.OutQuad
				duration: 100
			}
		}
		Behavior on scale {
			NumberAnimation {
				duration: 175
				easing.type: Easing.OutQuad
			}
		}
	}



	MouseArea {
		id: dragArea
		anchors.horizontalCenter: trackHead.horizontalCenter 
		implicitHeight: trackHead.height + 5
		implicitWidth: trackHead.width + 15
		drag.target: root.draggable ? trackHead : null
		drag.axis: Drag.XAxis 
		drag.minimumX: -(trackHead.width / 2) 
		drag.maximumX: root.width - (trackHead.width / 2)

		onPressed: {
			root.draggable ? trackHead.scale = 1.3 : null
		}
		onReleased: {
			root.draggable ? trackHead.scale = 1.0 : null
			if (!root.updateImmediately && root.draggable) {
				let percentage = (trackHead.x + (trackHead.width / 2)) / root.width
				root.valueUpdatedByDragging(percentage)
			}
		}
		onPositionChanged: {
			if (root.updateImmediately && root.draggable) {
				let percentage = (trackHead.x + (trackHead.width / 2)) / root.width
				root.valueUpdatedByDragging(percentage)
			}
		}
	}
}

