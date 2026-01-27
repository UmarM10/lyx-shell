import Quickshell
import Quickshell.Io
import QtQuick
import Qt5Compat.GraphicalEffects

import qs
import qs.common

import qs.modules.ControlCenter

PopupWindow {
    id: root
    visible: false
    color: "transparent"
    implicitWidth: 355
    implicitHeight: 450
    anchor.window: rootPanel
    anchor.rect.x: 5
    anchor.rect.y: 585
	mask: Region { item: background }

    function show() {
        showAnimation.restart();
    }
    function hide() {
        hideAnimation.restart();
    }

    Rectangle {
        id: background
        implicitWidth: 300
        implicitHeight: 450
        anchors.bottom: parent.bottom
        color: Colors.background
		opacity: 0.0
        radius: 15

        SequentialAnimation {
            id: showAnimation
            running: false
            PropertyAction {
                target: root
                property: "visible"
                value: true
            }
			ParallelAnimation {
				NumberAnimation {
					target: background
					property: "x"
					to: 55
					duration: 300
					easing.type: Easing.OutCubic
				}
				OpacityAnimator {
					target: background
					to: 1.0
					duration: 300
					easing.type: Easing.OutCubic
				}
			}
        }
        SequentialAnimation {
            id: hideAnimation
			ParallelAnimation {
				NumberAnimation {
					target: background
					property: "x"
					to: 15
					duration: 250
					easing.type: Easing.OutCubic
				}
				OpacityAnimator {
					target: background
					to: 0.0
					duration: 250
					easing.type: Easing.OutCubic
				}
			}
            PropertyAction {
                target: root
                property: "visible"
                value: "false"
            }
        }

		UserSection { id: userSection }
    }
}
