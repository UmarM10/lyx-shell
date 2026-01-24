import QtQuick

import qs.common

LyxButton {
	id: root
	anchors.horizontalCenter: parent.horizontalCenter
	implicitHeight: 47
	implicitWidth: 30
	
	Text {
		id: hours
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.verticalCenter: parent.verticalCenter
		horizontalAlignment: Text.AlignHCenter
		text: Qt.formatDateTime(clock.date, "hh\nmm AP").slice(0, 5)
		font.pixelSize: 20
		font.family: "SF Pro Display"
		font.weight: 700
		font.letterSpacing: 0.3
		color: root.foregroundColor
	}
}
