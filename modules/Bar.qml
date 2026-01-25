import Quickshell
import QtQuick

import qs
import qs.modules.Bar

PanelWindow {
    id: rootPanel
    anchors {
        left: true
        top: true
        bottom: true
    }
	margins {
        left: 5
        top: 5
        bottom: 5
		right: 5
	}

    implicitWidth: 45
    color: "transparent"

    Rectangle {
        id: background
        color: Colors.background
		opacity: 0.95
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

            NotificationsIcon {}
        }

        Column {
            id: centerOfBar
            anchors {
                centerIn: parent
                horizontalCenter: parent.horizontalCenter
            }
            spacing: 4.5

            Workspaces {}
        }

        Column {
            id: endOfBar
            anchors {
                bottom: parent.bottom
                bottomMargin: 10
                horizontalCenter: parent.horizontalCenter
            }
            spacing: 5
            
            TimeButton {}

            Rectangle {
                anchors.horizontalCenter: parent.horizontalCenter
                implicitHeight: 2
                implicitWidth: 28
                radius: 25
                color: Colors.primary
            }

			ControlsSection {}
        }
    }
}
