import Quickshell
import QtQuick 

import qs
import qs.common

PanelWindow {
	id: root

	width: 300 
	height: 200
	visible: true 
	color: Colors.surface 
	aboveWindows: false

	property var controlCenter
	property var sidebar
	
	Column {
		anchors.centerIn: parent 

		LyxButton {
			width: 140
			height: 50
			
			LyxText {
				anchors.centerIn: parent 
				font.pixelSize: 12 
				text: "Toggle Control Center"
			}

			onClicked: root.controlCenter.toggle()
		}

		LyxButton {
			width: 140 
			height: 50 

			LyxText {
				anchors.centerIn: parent 
				font.pixelSize: 12
				text: "Toggle Sidebar"
			}

			onClicked: root.sidebar.toggle()
		}
	}
}
