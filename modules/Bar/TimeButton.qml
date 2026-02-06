import QtQuick
import Quickshell

import qs.common
import qs.config

LyxButton {
	id: root
	anchors.horizontalCenter: parent.horizontalCenter
	implicitHeight: 47
	implicitWidth: 30
	
	SystemClock {
		id: clock
		precision: SystemClock.Seconds
	}
	LyxText {
		id: hours
		anchors.centerIn: parent
		horizontalAlignment: Text.AlignHCenter
		text: Qt.formatDateTime(clock.date, "hh\nmm AP").slice(0, 5)
		font.pixelSize: 20
		font.family: TextConfig.barClockFontFamily
		font.letterSpacing: 0.3
		color: root.foregroundColor
	}
}
