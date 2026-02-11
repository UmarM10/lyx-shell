// import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Services.UPower
import QtQuick

import qs
import qs.common
import qs.modules
import qs.services

import "./js/controls_bar_section.js" as Logic

Rectangle {
    id: root
    anchors.horizontalCenter: parent.horizontalCenter
    implicitWidth: 35
    implicitHeight: 65

    radius: 12
    color: Logic.getBackgroundColor()
    border.width: 2
    border.color: Colors.primaryContainer

	property var controlCenter

    Behavior on color {
        ColorAnimation {
            duration: 100
        }
    }
    Behavior on border.color {
        ColorAnimation {
            duration: 75
        }
    }

    // Volume Icon
    MaterialIcon {
        id: volumeIcon
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.top
        anchors.verticalCenterOffset: 15
        height: 19
        width: 19
        color: Colors.primary
        iconId: Audio.iconId
    }

    // Battery/Brightness Icon
    MaterialIcon {
        id: batteryBrightnessIcon
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        height: 19
        width: 19
        color: Colors.primary
        iconId: Battery.iconId
    }
    // Charging Icon
    Rectangle {
        id: chargingIcon
        visible: Battery.defaultBattery.state == UPowerDeviceState.Charging ? true : false
        x: 3
        y: 30
        radius: 20
        implicitHeight: 10
        implicitWidth: 10
        color: Colors.primaryContainer
        MaterialIcon {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            height: 8
            width: 8
            color: Colors.primary
            iconId: "bolt.svg"
        }
    }

    // Wi-Fi Icon
    MaterialIcon {
        id: wifiIcon
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.bottom
        anchors.verticalCenterOffset: -15
        height: 19
        width: 19
        color: Colors.primary

        iconId: Network.iconId
    }

    MaterialIcon {
        id: closeIcon
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        height: 20
        width: 20
        color: Colors.primary
        iconId: "close.svg"
        visible: false
    }

    states: [
        State {
            name: "pressed"
            PropertyChanges {
                volumeIcon {
                    visible: false
                }
                batteryBrightnessIcon {
                    visible: false
                }
                chargingIcon {
                    visible: false
                }
                wifiIcon {
                    visible: false
                }
                closeIcon {
                    visible: true
                }
                root {
                    color: Colors.primaryContainer
                    border.color: Colors.primary
                }
            }
		},
		State {
			name: ""
			PropertyChanges {
				volumeIcon { opacity: 1 }
				batteryBrightnessIcon { opacity: 1 }
				chargingIcon { opacity: 1 }
				wifiIcon { opacity: 1 }
			}
		}
    ]
    state: ""

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: onClickedFunc()
    }
    function onClickedFunc() {
        if (root.state == "") {
            pressedAnimation.restart();
            controlCenter.show();
        } else {
            root.state = "";
            revertAnimation.restart();
            controlCenter.hide();
        }
    }
    SequentialAnimation {
        id: pressedAnimation
        running: false
        ParallelAnimation {
            NumberAnimation {
                target: volumeIcon
                property: "anchors.verticalCenterOffset"
                to: 27
                duration: 150
                easing.type: Easing.OutCubic
            }
			OpacityAnimator {
				target: volumeIcon
				to: 0
				duration: 150
				easing.type: Easing.OutCubic
			}
            NumberAnimation {
                target: wifiIcon
                property: "anchors.verticalCenterOffset"
                to: -27
                duration: 150
                easing.type: Easing.OutCubic
            }
			OpacityAnimator {
				target: wifiIcon
				to: 0
				duration: 150 
				easing.type: Easing.OutCubic
			}
			OpacityAnimator {
				target: batteryBrightnessIcon
				to: 0
				duration: 150
				easing.type: Easing.OutCubic
			}
        }
        PropertyAction {
            target: root
            property: "state"
            value: "pressed"
        }
    }
    SequentialAnimation {
        id: revertAnimation
        running: false
        ParallelAnimation {
            NumberAnimation {
                target: volumeIcon
                property: "anchors.verticalCenterOffset"
                to: 15
                duration: 150
                easing.type: Easing.OutCubic
            }
            NumberAnimation {
                target: wifiIcon
                property: "anchors.verticalCenterOffset"
                to: -15
                duration: 150
                easing.type: Easing.OutCubic
            }
        }
    }

    // ControlCenter {
    //     id: controlCenter
    // }
}
