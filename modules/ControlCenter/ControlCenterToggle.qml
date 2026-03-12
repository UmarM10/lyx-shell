// import Quickshell 
import QtQuick 

import qs 
import qs.common 

ToggleButton {
	id: root
	implicitWidth: 125
	implicitHeight: 50
	radius: 10
	border.width: toggled ? 0 : 2
	border.color: Colors.primaryContainer

	property string iconId 
	property string title 
	property string toggledSubtitle

	MaterialIcon {
		anchors.left: parent.left 
		anchors.leftMargin: 15
		anchors.verticalCenter: parent.verticalCenter 
		iconId: root.iconId
		color: root.foregroundColor
		width: 21 
		height: 21
	}
	LyxText {
		anchors.verticalCenter: parent.verticalCenter 
		anchors.left: parent.left 
		anchors.leftMargin: 45
		anchors.verticalCenterOffset: root.toggled ? -7 : 0
		color: parent.foregroundColor 
		text: root.title
		font.pixelSize: 14

		Behavior on anchors.verticalCenterOffset {
			NumberAnimation { duration: 50; easing.type: Easing.OutQuad }
		}
	}
	LyxText {
		id: toggledSubtitle
		anchors.verticalCenter: parent.verticalCenter 
		anchors.left: parent.left 
		anchors.leftMargin: 45 
		anchors.verticalCenterOffset: 8
		color: parent.foregroundColor 
		elide: Text.ElideRight
		width: parent.width / 1.8
		font.pixelSize: 10
		opacity: root.toggled ? 1.0 : 0
		Behavior on opacity {
			NumberAnimation { duration: 100; easing.type: Easing.OutQuad }
		}

		text: root.toggledSubtitle
	}
}
