import Quickshell
import QtQuick 

import qs
import qs.common 

Column {
	anchors.top: parent.top 
	anchors.left: parent.left 
	anchors.topMargin: 10
	anchors.leftMargin: 10

	SystemClock {
		id: clock 
		precision: SystemClock.Seconds
	}

	LyxText {
		usePercentSize: true
		percentSize: 1.7
		weightModifier: +100
		color: Colors._onSurface 
		text: Qt.formatDateTime(clock.date, "hh:mm:ss AP")
	}
	LyxText {
		usePercentSize: true 
		percentSize: 1.1
		weightModifier: -200
		color: Colors._onSurface 
		text: Qt.formatDateTime(clock.date, "dddd, MMMM d, yyyy")
	}
}
