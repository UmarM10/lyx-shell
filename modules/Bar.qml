import Quickshell
import Quickshell.Wayland
import QtQuick

import qs
import qs.common
import qs.config
import qs.modules.Bar

PanelWindow {
    id: barPanel
	WlrLayershell.namespace: "lyx-bar"
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
    color: "transparent"

	property alias controlCenter: controlsSection.controlCenter

    Rectangle {
        id: background
        color: Colors.background
        opacity: Config.values.shellOpacity
 		topLeftRadius: Config.values.screenCornerRounding * 1
		bottomLeftRadius: Config.values.screenCornerRounding * 1

		Behavior on color { ColorAnimation { duration: 500; easing.type: Easing.OutQuad } }

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.fill: parent
    }

	// Virtual Rounded Screen
	Corner {
		anchors.top: parent.top 
		anchors.left: parent.left 
		target: parent
		corner: "topLeft"
		radius: Config.values.screenCornerRounding
		color: "black"
	}
	Corner {
		anchors.bottom: parent.bottom
		anchors.left: parent.left 
		target: parent
		corner: "bottomLeft"
		radius: Config.values.screenCornerRounding
		color: "black"
	}

	Column {
		id: startOfBar
		spacing: 5
		anchors {
			top: parent.top
			topMargin: 10
			horizontalCenter: parent.horizontalCenter
		}

		NotificationsIcon {}
		SystemTray {}
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
