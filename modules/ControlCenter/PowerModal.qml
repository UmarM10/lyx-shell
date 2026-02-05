import Quickshell
import QtQuick

import qs
import qs.common

Modal {
	id: root

	LyxButton {
		id: backButton
		implicitWidth: 30
		implicitHeight: 30
		radius: 15
		anchors.left: parent.left
		anchors.leftMargin: 20
		y: 10

		MaterialIcon {
			anchors.centerIn: parent
			color: backButton.foregroundColor
			iconId: "arrow-back.svg"
		}
		
		onClicked: root.hide()
	}

	LyxText {
		font.pointSize: 12
		font.weight: 600
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.top: parent.top
		anchors.topMargin: 15
		text: "Power Options"
	}
}
