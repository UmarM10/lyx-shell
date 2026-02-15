import Quickshell
import Quickshell.Widgets
import Quickshell.Services.SystemTray
import QtQuick 

import qs 
import qs.common 

Column {
	id: root 
	width: 60 
	spacing: 6

	property bool expanded: false

	LyxButton {
		id: toggleCollapseButton 
		anchors.horizontalCenter: parent.horizontalCenter

		MaterialIcon {
			anchors.centerIn: parent
			iconId: "chevron-down.svg"
			color: toggleCollapseButton.foregroundColor
			width: 28; height: 28

			rotation: root.expanded ? 180 : 0
			Behavior on rotation {
				NumberAnimation {
					duration: 200 
					easing.type: Easing.OutQuad
				}
			}
		}

		onClicked: root.expanded = !root.expanded
	}

	Item {
		id: collapseWrapper 
		width: parent.width 
		clip: true 

		height: root.expanded ? systemTrayIconList.implicitHeight : 0
		Behavior on height {
			NumberAnimation { duration: 300; easing.type: Easing.OutExpo }
		}

		opacity: root.expanded ? 1.0 : 0.0
		Behavior on opacity {
			NumberAnimation { duration: 300; easing.type: Easing.OutExpo }
		}

		Column {
			id: systemTrayIconList 
			width: parent.width
			spacing: 5

			// Example Icons
            // Repeater {
            //     model: 4 // Create 4 dummy icons
            //     delegate: Rectangle {
            //         width: 35
            //         height: 35
            //         radius: 20 // Circle
            //         color: Qt.hsla(index * 0.2, 0.7, 0.5, 1) // Different colors
            //         anchors.horizontalCenter: parent.horizontalCenter
            //
            //         Text {
            //             text: index + 1
            //             anchors.centerIn: parent
            //             color: "white"
            //         }
            //     }
            // }
			
			Repeater {
				model: SystemTray.items 

				property var modelData

				delegate: Rectangle {
					id: systemTrayItem
					color: mouseArea.containsMouse ? Colors.topPrimary : Colors.primaryContainer
					width: 32
					height: 32
					radius: 20 
					anchors.horizontalCenter: parent.horizontalCenter

					Behavior on color {
						ColorAnimation { duration: 100; easing.type: Easing.OutQuad }
					}

					ClippingRectangle {
						anchors.centerIn: parent 
						anchors.horizontalCenterOffset: 1
						anchors.verticalCenterOffset: 1
						color: "transparent"
						radius: 5
						width: 19 
						height: 19 

						Image {
							sourceSize {
								width: 19
								height: 19
							}
							anchors.fill: parent
							source: modelData.icon
						}
					}

					MouseArea {
						id: mouseArea
						anchors.fill: parent 
						hoverEnabled: true
						acceptedButtons: Qt.LeftButton | Qt.RightButton
						onClicked: (mouse) => handler(mouse)

						function handler(mouse) {
							if (modelData.onlyMenu) {
								systemTrayItemMenu.toggle()
							} else if (mouse.button === Qt.LeftButton && !systemTrayItemMenu.visible ) {
								modelData.activate() 
								root.expanded = false
							} else {
								systemTrayItemMenu.toggle()
							}
						}
					}

					QsMenuOpener {
						id: systemTrayItemOpener
						menu: modelData.menu
					}

					PopupWindow {
						id: systemTrayItemMenu
						anchor.window: barPanel 
						anchor.rect.y: systemTrayItem.y + 25
						anchor.rect.x: 20
						implicitWidth: popupBackground.width + 40
						implicitHeight: popupBackground.height
						color: "transparent"

						mask: Region { item: popupBackground }

						function show() { showAnimation.restart() }
						function hide() { hideAnimation.restart() }
						function toggle() {
							if (visible) {
								hideAnimation.restart()
							} else {
								showAnimation.restart()
							}
						}

						Rectangle {
							id: popupBackground
							x: 0
							implicitWidth: 125
							implicitHeight: menu.implicitHeight + 10
							color: Colors.primaryContainerVariant 
							radius: 20
							opacity: 0.0
							border {
								width: 3 
								color: Colors.primaryContainer
							}

							ParallelAnimation {
								id: showAnimation 
								PropertyAction { target: systemTrayItemMenu; property: "visible"; value: true }
								OpacityAnimator {
									target: popupBackground 
									to: 1.0 
									duration: 150 
									easing.type: Easing.OutExpo
								}
								NumberAnimation {
									target: popupBackground
									property: "x"
									to: 40
									duration: 300 
									easing.type: Easing.OutExpo
								}
							}
							SequentialAnimation {
								id: hideAnimation 
								ParallelAnimation {
									OpacityAnimator {
										target: popupBackground 
										to: 0.0 
										duration: 250
										easing.type: Easing.OutExpo
									}
									NumberAnimation {
										target: popupBackground
										property: "x" 
										to: 0 
										duration: 500 
										easing.type: Easing.OutExpo 
									}
								}
								PropertyAction { target: systemTrayItemMenu; property: "visible"; value: false }
							}

							Column {
								id: menu
								anchors.centerIn: parent
								spacing: 3

								Repeater {
									model: systemTrayItemOpener.children 
									delegate: LyxButton {
										anchors.horizontalCenter: parent.horizontalCenter 
										implicitWidth: popupBackground.implicitWidth - 10 
										implicitHeight: 20

										color: modelData.isSeparator ? Colors.primaryContainerVariant : backgroundColor
										LyxText {
											anchors.centerIn: parent 
											text: modelData.text
											color: parent.foregroundColor
										}

										onClicked: {
											modelData.triggered();
											systemTrayItemMenu.hide();
										}
									}
								}
							}
						}
					}
				}
			}
		}
	}
}
