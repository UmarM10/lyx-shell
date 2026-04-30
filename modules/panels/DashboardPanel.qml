import Quickshell 
import Quickshell.Wayland
import QtQuick 
import QtQuick.Effects

import qs 
import qs.common 
import qs.config
import qs.modules

PanelWindow {
	id: dashboardPanel
	anchors.bottom: true 
	margins.bottom: 10
	implicitWidth: 725 
	implicitHeight: 350
	visible: true
	aboveWindows: true 
	WlrLayershell.namespace: "lyx-dashboard"
	exclusionMode: ExclusionMode.Ignore
	exclusiveZone: 0
	mask: Region { item: dashboard.opacity === 0.0 ? null : dashboard }
	
	color: "transparent"

	Dashboard { id: dashboard; dashboardPanel: dashboardPanel }

	RectangularShadow {
		anchors.bottom: dashboard.bottom 
		anchors.horizontalCenter: parent.horizontalCenter
		width: dashboard.width + 5
		visible: dashboard.visible && !(dashboard.state === "invisible")
		height: dashboard.height + 5
		color: "#80000000"
		radius: Config.values.cornerRounding
		offset: Qt.point(0, 2)
		z: -1
	}

	Corner {
		id: dashboardLeftCorner 
		target: dashboard 
		anchors.right: target.left 
		anchors.bottom: target.bottom 
		radius: Config.values.cornerRounding 
		corner: "bottomRight"
		color: Colors.background
	}
	Corner {
		id: dashboardRightCorner 
		target: dashboard 
		anchors.left: target.right
		anchors.bottom: target.bottom 
		radius: Config.values.cornerRounding 
		corner: "bottomLeft"
		color: Colors.background
	}
}
