import QtQuick 

import qs 
import qs.config
import qs.common

Rectangle {
	id: root 
	anchors.horizontalCenter: parent.horizontalCenter 
	implicitWidth: parent.width - 15
	implicitHeight: 80

	radius: Config.values.cornerRounding * 0.5
	color: Colors.primaryContainer

	LyxText {
		id: title 
		anchors.top: parent.top 
		anchors.left: parent.left 
		anchors.topMargin: 5 
		anchors.leftMargin: 5 

		text: "Battery"
	}
}
