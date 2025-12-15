import Quickshell
import Quickshell.Hyprland
import Quickshell.Services.Pipewire
import QtQuick

import "./Bar"
import ".."

PanelWindow {
    anchors {
        left: true
        top: true
        bottom: true
    }
    margins {
        left: 5
        top: 5
        bottom: 5
    }
    implicitWidth: 45
    color: "transparent"

    Rectangle {
        id: background
        anchors.fill: parent
        color: Colors.background
        radius: 10

        Column {
            id: startOfBar
            anchors {
                top: parent.top
                topMargin: 10
                horizontalCenter: parent.horizontalCenter
            }

            Text {
                text: "WIP"
                font.pixelSize: 10
                color: Colors.primary
            }
        }

        Column {
            id: centerOfBar
            anchors {
                centerIn: parent
                horizontalCenter: parent.horizontalCenter
            }
            spacing: 4.5

            Repeater {
                id: workspaces
                model: Hyprland.workspaces
                Rectangle {
                    implicitWidth: 20
                    implicitHeight: Hyprland.focusedWorkspace.id == modelData.id ? 63.5 : 17
                    radius: 10

                    // Workspace Colors
                    gradient: Gradient {
                        id: workspaceColor
                        GradientStop {
                            position: 0.0

                            color: workspaceMouseArea.containsMouse ? Colors.primary : Hyprland.focusedWorkspace.id == modelData.id ? Colors.primaryDark : Colors.primaryContainer

                            Behavior on color {
                                ColorAnimation {
                                    duration: 150
                                    easing.type: Easing.OutQuad
                                }
                            }
                        }
                        GradientStop {
                            position: 1.0

                            color: workspaceMouseArea.containsMouse ? Colors.primary : Hyprland.focusedWorkspace.id == modelData.id ? Colors.primaryLight : Colors.primaryContainerVariant

                            Behavior on color {
                                ColorAnimation {
                                    duration: 150
                                    easing.type: Easing.OutQuad
                                }
                            }
                        }
                    }

                    // Switching Animation
                    Behavior on implicitHeight {
                        NumberAnimation {
                            duration: 200
                            easing.type: Easing.OutQuad
                        }
                    }

                    // Go to selected workspace
                    MouseArea {
                        id: workspaceMouseArea
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: Hyprland.dispatch("workspace " + modelData.id)
                    }
                }
            }
        }

        Column {
            id: endOfBar
            anchors {
                bottom: parent.bottom
                bottomMargin: 10
                horizontalCenter: parent.horizontalCenter
            }
            spacing: 3

            SystemClock {
                id: clock
                precision: SystemClock.Seconds
            }
            Text {
                id: hours
                anchors.horizontalCenter: parent.horizontalCenter
                horizontalAlignment: Text.AlignHCenter
                text: Qt.formatDateTime(clock.date, "hh\nmm AP").slice(0, 5)
                font.pixelSize: 20
                font.family: "SF Pro Display"
                font.weight: 600
                font.letterSpacing: 0.3
                color: Colors.primary
            }

            Rectangle {
                anchors.horizontalCenter: parent.horizontalCenter
                implicitHeight: 2
                implicitWidth: 28
                radius: 25
                color: Colors.primary
            }

			VolumeIcon{}
        }
    }
}
