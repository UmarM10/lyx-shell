import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Shapes
import QtQuick.Effects

import qs
import qs.common
import qs.config

Variants {
	model: Quickshell.screens

	delegate: Component {
		PanelWindow {
			id: rootOverlayPanel
			WlrLayershell.namespace: "lyx-overlay"
			mask: Region { 
				Region { item: controlCenter }
			}

			required property var modelData

			anchors {
				top: true; bottom: true; left: true; right: true
			}
			color: "transparent"
			screen: modelData

			RectangularShadow {
				id: barShadow
				anchors.left: parent.left
				anchors.leftMargin: -2
				width: 7
				height: parent.height
				opacity: 0.5
			}
			RectangularShadow {
				id: topShadow
				anchors.top: parent.top 
				anchors.topMargin: 8
				height: 7 
				width: parent.width 
				opacity: 0.5
			}
			RectangularShadow {
				id: rightShadow 
				anchors.right: parent.right 
				anchors.rightMargin: 8
				height: parent.height 
				width: 7
				opacity: 0.5
			}
			RectangularShadow {
				id: bottomShadow
				anchors.bottom: parent.bottom
				anchors.bottomMargin: 8
				height: 7 
				width: parent.width 
				opacity: 0.5
			}

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
					opacity: Config.values.shellOpacity

					ShapePath {
						strokeWidth: 0
						fillColor: Colors.background

						Behavior on fillColor { ColorAnimation { duration: 500; easing.type: Easing.OutQuad } }
									
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
							
							radius: Config.values.screenCornerRounding * 1.2
						}
					}
				}
				// Virtual Rounded Screen
				Corner {
					target: background
					corner: "topRight"
					radius: Config.values.screenCornerRounding
					color: "black"

					anchors.top: target.top
					anchors.right: target.right
				}
				Corner {
					target: background
					corner: "bottomRight"
					radius: Config.values.screenCornerRounding
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
			ControlCenter { id: controlCenter }
		}
	}
}
