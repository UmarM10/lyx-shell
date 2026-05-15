import Quickshell
import Quickshell.Wayland
import QtQuick
import Qt5Compat.GraphicalEffects
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
			mask: Region {}

			required property var modelData
			readonly property bool primaryMonitor: screen === Quickshell.screens[0]
			readonly property bool translucent: Config.values.shellOpacity < 1.0

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
				visible: !rootOverlayPanel.translucent
			}
			RectangularShadow {
				id: topShadow
				anchors.top: parent.top 
				anchors.topMargin: 8
				height: 7 
				width: parent.width 
				opacity: 0.5
				visible: !rootOverlayPanel.translucent
			}
			RectangularShadow {
				id: rightShadow 
				anchors.right: parent.right 
				anchors.rightMargin: 8
				height: parent.height 
				width: 7
				opacity: 0.5
				visible: !rootOverlayPanel.translucent
			}
			RectangularShadow {
				id: bottomShadow
				anchors.bottom: parent.bottom
				anchors.bottomMargin: 8
				height: 7 
				width: parent.width 
				opacity: 0.5
				visible: !rootOverlayPanel.translucent
			}
			RectangularShadow {
				id: leftShadow 
				visible: !rootOverlayPanel.primaryMonitor && !rootOverlayPanel.translucent
				anchors.left: parent.left
				anchors.leftMargin: 8
				width: 7 
				height: parent.height
				opacity: 0.5
			}

			Rectangle {
				id: background	
				anchors.fill: parent
				
				color: "transparent"

				Item {
					id: borderContent
					anchors.fill: parent
					visible: false
					layer.enabled: true

					Image {
						id: blurSource
						anchors.fill: parent
						source: ShellState.values.currentWallpaperPath
						visible: false
					}

					FastBlur {
						anchors.fill: parent
						source: blurSource
						radius: 50 
					}

					Rectangle {
						anchors.fill: parent
						color: Colors.surface
						opacity: Config.values.shellOpacity

						Behavior on color { 
							ColorAnimation { duration: 500; easing.type: Easing.OutQuad } 
						}
					}
				}

				// Screen Border
				Shape {
					id: borderShape
					anchors.fill: parent
					visible: false
					layer.enabled: true
					layer.samples: 10
					opacity: Config.values.shellOpacity

					ShapePath {
						strokeWidth: 0
						fillColor: Colors.surface

						Behavior on fillColor { ColorAnimation { duration: 500; easing.type: Easing.OutQuad } }

						PathRectangle {
							x: 0; y: 0
							width: borderShape.width
							height: borderShape.height
						}

						PathRectangle {
							x: rootOverlayPanel.primaryMonitor ? 0 : 10
							y: 10
							width: borderShape.width - (rootOverlayPanel.primaryMonitor ? 10 : 20)
							height: borderShape.height - 20 
							
							radius: Config.values.screenCornerRounding * 1.2
						}
					}
				}
				OpacityMask {
					anchors.fill: parent
					source: borderContent
					maskSource: borderShape
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
		}
	}
}
