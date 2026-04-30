import QtQuick 
import Quickshell 
import Quickshell.Wayland
import Quickshell.Hyprland

import qs 
import qs.modules

PanelWindow {
	id: osdPanel
	implicitWidth: 325
	implicitHeight: 260
	
	mask: Region { item: osd }
	WlrLayershell.layer: WlrLayer.Overlay
	exclusionMode: ExclusionMode.Ignore 
	aboveWindows: true
	anchors {
		top: true 
	}

	color: "transparent"

	OSD { id: osd; y: {
		if (Hyprland.focusedWorkspace.hasFullscreen) {
			return 0
		} else return 10
	}}
}
