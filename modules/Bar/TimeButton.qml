import QtQuick

import qs
import "js/bar_icon.js" as BarIconLogic

Rectangle {
	anchors.horizontalCenter: parent.horizontalCenter
	implicitHeight: 47
	implicitWidth: 30
	radius: 5
	color: BarIconLogic.getBackgroundColor()
	Behavior on color {
        ColorAnimation {
            duration: 75
            easing.type: Easing.OutQuad
        }
    }
	
	Text {
		id: hours
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.verticalCenter: parent.verticalCenter
		horizontalAlignment: Text.AlignHCenter
		text: Qt.formatDateTime(clock.date, "hh\nmm AP").slice(0, 5)
		font.pixelSize: 20
		font.family: "SF Pro Display"
		font.weight: 600
		font.letterSpacing: 0.3
		color: BarIconLogic.getForegroundColor()
		Behavior on color {
			ColorAnimation {
				duration: 75
				easing.type: Easing.OutQuad
			}
		}
	}

	MouseArea {
		id: mouseArea
		anchors.fill: parent
		hoverEnabled: true
	}
}
