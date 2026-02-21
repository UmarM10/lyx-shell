import Quickshell
import Quickshell.Widgets
import QtQuick

import qs
import qs.common
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
        aboveWindows: false
        color: Colors.background

		Connections {
			target: Wallpaper
			function onCurrentPathChanged() { swapWallpaperAnimation.restart() }
		}

        SequentialAnimation {
            id: swapWallpaperAnimation
            running: true

			PropertyAction { target: newImageWrapper; property: "x"; value: 600 } 
			PropertyAction { target: newImageWrapper; property: "y"; value: 500 } 
			PropertyAction { target: newImageWrapper; property: "radius"; value: newImageWrapper.width / 2 } 
            PropertyAction {
                target: newImageWrapper
                property: "visible"
                value: true
            }
            ParallelAnimation {
				NumberAnimation {
					// Enlarge on width
					target: newImageWrapper
					property: "implicitWidth"
					to: background.width
					duration: 1000
					easing.type: Easing.OutExpo
				}

				NumberAnimation {
					// Enlarge on height
					target: newImageWrapper
					property: "implicitHeight"
					to: background.height
					duration: 1000
					easing.type: Easing.OutExpo
				}
				NumberAnimation {
					// Reduce x
					target: newImageWrapper
					property: "x"
					to: 0
					duration: 1000
					easing.type: Easing.OutExpo
				}
				NumberAnimation {
					// Reduce y
					target: newImageWrapper
					property: "y"
					to: 0
					duration: 1000
					easing.type: Easing.OutExpo
				}
				SequentialAnimation {
					PauseAnimation {
						duration: 150
					}
					NumberAnimation {
						// Reduce radius
						target: newImageWrapper
						property: "radius"
						to: 0
						duration: 1000
						easing.type: Easing.OutExpo
					}
				}
            }

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
        }

        AnimatedImage {
            id: currentImage
			sourceSize.width: background.width 
			sourceSize.height: background.height 

            fillMode: Image.PreserveAspectCrop
        }
        ClippingRectangle {
            id: newImageWrapper
            x: 600
            y: 500
            radius: width / 2
            color: Colors.background
            implicitWidth: 1
            implicitHeight: 1
            AnimatedImage {
                id: newImage
                sourceSize.width: background.width
                sourceSize.height: background.height
                source: Wallpaper.currentPath
                fillMode: Image.PreserveAspectCrop
            }
        }
    }
}
