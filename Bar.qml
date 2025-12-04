import Quickshell
import Quickshell.Hyprland
import Quickshell.Services.Pipewire
import Quickshell.Io
import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects


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
                color: background.color == Colors.background ? Colors.primary : Colors.topPrimary
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

                            color: workspaceMouseArea.containsMouse ? 
                            Colors.primary : Hyprland.focusedWorkspace.id == modelData.id ?
                            Colors.primaryDark : Colors.primaryContainer

                            Behavior on color {
                                ColorAnimation {
                                    duration: 150
                                    easing.type: Easing.OutQuad
                                }
                            }
                        }
                        GradientStop { 
                            position: 1.0

                            color: workspaceMouseArea.containsMouse ?
                            Colors.primary : Hyprland.focusedWorkspace.id == modelData.id ?
                            Colors.primaryLight : Colors.primaryContainerVariant

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
                text: Qt.formatDateTime(clock.date, "hh\nmm AP").slice(0,5)
                font.pixelSize: 20
                font.family: "SF Pro Display"
                font.weight: 600
                font.letterSpacing: 0.3
                color: background.color == Colors.background ? Colors.primary : Colors.topPrimary
            }

            Rectangle {
                anchors.horizontalCenter: parent.horizontalCenter
                implicitHeight: 2
                implicitWidth: 28
                radius: 25
                color: Colors.primary
            }

            Button {
                background: Rectangle {color: "transparent"; anchors.horizontalCenter: parent.horizontalCenter}
                anchors.horizontalCenter: parent.horizontalCenter
                padding: 0
                id: volumeIcon

                contentItem: Image {
                    anchors.horizontalCenter: parent.horizontalCenter
                    height: 21
                    width: 21
                    sourceSize.width: width
                    sourceSize.height: height
                    
                    PwObjectTracker {
                        objects: Pipewire.nodes.values
                    }
                    property var activeSink: Pipewire.defaultAudioSink.audio
                    function getAudioIconPath() {
                        if (!activeSink) return "icons/volume-xmark-solid-full.svg"
                        else if (activeSink.muted) {
                            return "icons/volume-xmark-solid-full.svg"
                        } else if (activeSink.volume >= 0.75) {
                            return "icons/volume-high-solid-full.svg"
                        } else if (activeSink.volume >= 0.50) {
                            return "icons/volume-low-solid-full.svg"
                        } else if (activeSink.volume >= 0.25) {
                            return "icons/volume-low-solid-full.svg"
                        } else {
                            return "icons/volume-off-solid-full.svg"
                        }
                    }
                    source: getAudioIconPath()

                    ColorOverlay {
                        anchors.fill: parent
                        source: parent
                        color: Colors.primary
                    }
                }
            }
        }
    }
}