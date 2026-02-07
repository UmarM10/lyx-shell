import Quickshell
import QtQuick

import qs
import qs.common
import qs.modules.Bar

PanelWindow {
    id: barPanel
    anchors {
        left: true
        top: true
        bottom: true
    }
    // margins {
    //     left: 5
    //     top: 5
    //     bottom: 5
    //     right: 5
    // }

    implicitWidth: 55
    color: "black"

	property alias controlCenter: controlsSection.controlCenter

    Rectangle {
        id: background
        color: Colors.background
        // opacity: 0.95
        // radius: 10

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.fill: parent
		topLeftRadius: 15
		bottomLeftRadius: 15

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

			Separator { anchors.horizontalCenter: parent.horizontalCenter }

			ControlsSection { id: controlsSection }
		}	
    }
}
