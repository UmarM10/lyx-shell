import Quickshell 
import Quickshell.Wayland
import QtQuick 

import qs

PanelWindow {
	id: sidebarPanel

	visible: false

	property bool rightSidebar: false // If the sidebar should spawn from the right

	WlrLayershell.namespace: "lyx-sidebar"
	WlrLayershell.exclusiveZone: 0
	
	anchors {
		top: true 
		left: true 
		bottom: true
	}

	implicitWidth: 300 
	color: Colors.surface
}
