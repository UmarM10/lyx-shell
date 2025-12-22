import Quickshell
import QtQuick

import qs
import qs.modules.Bar

PanelWindow {
    anchors {
        left: true
        top: true
        bottom: true
    }
    margins {
        left: 5
        top: 5
        bottom: 5
    }
    implicitWidth: 45
    color: "transparent"

    Rectangle {
        id: background
        color: Colors.background
        radius: 10

		anchors.horizontalCenter: parent.horizontalCenter
		anchors.verticalCenter: parent.verticalCenter
		anchors.fill: parent

        Column {
            id: startOfBar
            anchors {
                top: parent.top
                topMargin: 10
                horizontalCenter: parent.horizontalCenter
            }
			
			NotificationsIcon{}
        }

        Column {
            id: centerOfBar
            anchors {
                centerIn: parent
                horizontalCenter: parent.horizontalCenter
            }
            spacing: 4.5

			Workspaces{}
        }

        Column {
            id: endOfBar
            anchors {
                bottom: parent.bottom
                bottomMargin: 10
                horizontalCenter: parent.horizontalCenter
            }
            spacing: 3

            SystemClock {
                id: clock
                precision: SystemClock.Seconds
            }
            Text {
                id: hours
                anchors.horizontalCenter: parent.horizontalCenter
                horizontalAlignment: Text.AlignHCenter
                text: Qt.formatDateTime(clock.date, "hh\nmm AP").slice(0, 5)
                font.pixelSize: 20
                font.family: "SF Pro Display"
                font.weight: 600
                font.letterSpacing: 0.3
                color: Colors.primary
            }

            Rectangle {
                anchors.horizontalCenter: parent.horizontalCenter
                implicitHeight: 2
                implicitWidth: 28
                radius: 25
                color: Colors.primary
            }

			VolumeIcon{}
        }
    }
}
