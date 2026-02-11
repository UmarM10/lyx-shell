import Quickshell
import QtQuick
import QtQuick.Shapes

import qs
import qs.common

Variants {
	model: Quickshell.screens

	delegate: Component {
		PanelWindow {
			id: rootOverlayPanel
			mask: Region { 
				Region { item: controlCenter }
				Region { item: osd }
			}

			required property var modelData

			anchors {
				top: true; bottom: true; left: true; right: true
			}
			color: "transparent"
			screen: modelData

			Rectangle {
				id: background	
				anchors.fill: parent
				
				color: "transparent"

				// Screen Border
				Shape {
					id: screenBorder
					anchors.fill: parent
					layer.enabled: true
					layer.samples: 10

					ShapePath {
						strokeWidth: 0
						fillColor: Colors.background
									
						PathRectangle {
							x: 0; y: 0
							width: screenBorder.width
							height: screenBorder.height
						}

						PathRectangle {
							x: 0
							y: 10
							width: screenBorder.width - 10
							height: screenBorder.height - 20 
							
							radius: 20 
						}
					}
				}
				// Virtual Rounded Screen
				Corner {
					target: background
					corner: "topRight"
					radius: 25
					color: "black"

					anchors.top: target.top
					anchors.right: target.right
				}
				Corner {
					target: background
					corner: "bottomRight"
					radius: 25
					color: "black"

					anchors.bottom: target.bottom
					anchors.right: target.right
				}
			}

			Bar { 
				id: bar
				screen: rootOverlayPanel.modelData
				controlCenter: controlCenter
			}
			OSD { id: osd }
			ControlCenter { id: controlCenter }

		}
	}
}
