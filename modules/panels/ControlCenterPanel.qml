import Quickshell
import QtQuick 
import Quickshell.Wayland

import qs
import qs.common
import qs.modules

PanelWindow {
	id: controlCenterPanel
	implicitWidth: controlCenter.controlCenterWidth + 30
	implicitHeight: controlCenter.controlCenterHeight + 30

	property var controlCenter: controlCenter

	mask: Region { item: controlCenter }
	WlrLayershell.layer: WlrLayer.Top
	aboveWindows: true 
	anchors {
		bottom: true 
		left: true
	}
	
	color: "transparent"

	ControlCenter { id: controlCenter }
}
