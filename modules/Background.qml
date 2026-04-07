import Quickshell
import Quickshell.Widgets
import Quickshell.Wayland
import QtQuick

import qs
import qs.services

Variants {
    id: root
    model: Quickshell.screens

    delegate: PanelWindow {
        id: background
        required property var modelData
        screen: modelData
        anchors {
            top: true
            right: true
            bottom: true
            left: true
        }
		WlrLayershell.layer: WlrLayer.Background
		WlrLayershell.exclusiveZone: -1
		exclusionMode: ExclusionMode.Ignore
        color: Colors.background

		Connections {
			target: Wallpaper
			function onCurrentPathChanged() { swapWallpaperAnimationNew.restart() }
		}

		SequentialAnimation {
			id: swapWallpaperAnimationNew
			running: true

			// Set New Image Source 
			PropertyAction {
				target: newImage 
				property: "source"
				value: Wallpaper.currentPath
			}

			// Reset New Image Size 
			PropertyAction {
				target: newImageWrapper 
				properties: "implicitWidth,implicitHeight"
				value: 1
			}

			// Reset New Image Position
			PropertyAction {
				target: newImageWrapper 
				property: "x"
				value: 600 
			}
			PropertyAction {
				target: newImageWrapper 
				property: "y"
				value: 500 
			}

			// Reset New Image Radius 
			PropertyAction {
				target: newImageWrapper 
				property: "radius"
				value: background.width / 2
			}
			
			// Make New Image Visible 
			PropertyAction {
				target: newImageWrapper 
				property: "visible"
				value: true
			}

			// Animation Start
			ParallelAnimation {
				// Increase Size to Fit Screen
				NumberAnimation {
					target: newImageWrapper 
					property: "implicitWidth"
					to: background.width 
					duration: 1000
					easing.type: Easing.OutExpo
				}
				NumberAnimation {
					target: newImageWrapper 
					property: "implicitHeight"
					to: background.height 
					duration: 1000
					easing.type: Easing.OutExpo
				}

				// Decrease Position to Center
				NumberAnimation {
					target: newImageWrapper
					properties: "x,y"
					to: 0 
					duration: 1000
					easing.type: Easing.OutExpo
				}

				// Decrease Radius to 0
				NumberAnimation {
					target: newImageWrapper 
					property: "radius"
					to: 0
					duration: 1000
					easing.type: Easing.OutExpo
				}
			}

			// Hide New Image & Update Current Image
			PropertyAction {
				target: currentImage 
				property: "source"
				value: newImage.source
			}
			PropertyAction {
				target: newImageWrapper 
				property: "visible"
				value: false
			}
			PropertyAction {
				target: newImage
				property: "source"
				value: undefined
			}
		}
		
        AnimatedImage {
            id: currentImage
			sourceSize.width: background.width 
			sourceSize.height: background.height 
			z: -1

            fillMode: Image.PreserveAspectCrop
        }
        ClippingRectangle {
            id: newImageWrapper
			z: 1
            x: 600
            y: 500
            radius: width / 2
            color: Colors.background
			visible: false
            implicitWidth: 1
            implicitHeight: 1
            AnimatedImage {
                id: newImage
				x: -newImageWrapper.x
                y: -newImageWrapper.y
                sourceSize.width: background.width
                sourceSize.height: background.height
                source: Wallpaper.currentPath
                fillMode: Image.PreserveAspectCrop
            }
        }
    }
}
