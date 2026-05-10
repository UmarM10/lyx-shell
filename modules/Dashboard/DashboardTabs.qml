import Quickshell
import QtQuick

import qs 
import qs.common

Rectangle {
	id: root
	anchors.horizontalCenter: parent.horizontalCenter
	anchors.bottom: parent.bottom
	anchors.bottomMargin: 20

	implicitWidth: parent.width - 15
	implicitHeight: 60
	color: "transparent"
	radius: 10

	property var dashboard

	readonly property Item activeTab: {
		if (clocksTab.activeState) return clocksTab;
		if (calendarTab.activeState) return calendarTab;
		if (dashTab.activeState) return dashTab;
		if (launcherTab.activeState) return launcherTab;
		if (wallpapersTab.activeState) return wallpapersTab;
		return null;
	}

	// This wrapper is necessary because for some reason the animations of the line above the current tab.
	Item {
		id: tabContainer
		anchors.centerIn: parent
		
		implicitWidth: rowOfTabs.implicitWidth
		implicitHeight: rowOfTabs.implicitHeight

		Separator {
			id: currentPageIndicator 
			orientation: "horizontal"
			implicitWidth: 100
			thickness: 3

			visible: root.dashboard.state === "invisible" ? false : true

			x: root.activeTab ? (rowOfTabs.x + root.activeTab.x + (root.activeTab.width / 2) - (width / 2)) : dashTab.x + (root.activeTab.width / 2)
			y: root.activeTab ? (rowOfTabs.y - height - 5) : 0 

			Behavior on x {
				NumberAnimation { duration: 200; easing.type: Easing.OutExpo }
			}
			Behavior on opacity {
				NumberAnimation { duration: 50 }
			}
		}

		Row {
			id: rowOfTabs
			anchors.centerIn: parent
			spacing: 10

			LyxButton {
				id: clocksTab
				anchors.bottom: parent.bottom
				property bool activeState: root.dashboard.state === "clocks"
				implicitWidth: activeState ? 100 : 90
				implicitHeight: activeState ? 50 : 40
				LyxText {
					anchors.centerIn: parent 
					text: "Clocks"
					usePercentSize: true
					percentSize: parent.activeState ? 1.2 : 1.0 
					weightModifier: parent.activeState ? 100 : 0
					color: parent.foregroundColor
				}
				Behavior on implicitWidth { NumberAnimation { duration: 200 } }
				Behavior on implicitHeight { NumberAnimation { duration: 200 } }
				Behavior on scale { NumberAnimation { duration: 200 } }
				onClicked: root.dashboard.state = "clocks"
			}

			LyxButton {
				id: calendarTab
				anchors.bottom: parent.bottom
				property bool activeState: root.dashboard.state === "calendar"
				implicitWidth: activeState ? 100 : 90
				implicitHeight: activeState ? 50 : 40
				LyxText {
					anchors.centerIn: parent 
					text: "Calendar"
					usePercentSize: true
					percentSize: parent.activeState ? 1.2 : 1.0 
					weightModifier: parent.activeState ? 100 : 0
					color: parent.foregroundColor
				}
				Behavior on implicitWidth { NumberAnimation { duration: 100 } }
				Behavior on implicitHeight { NumberAnimation { duration: 100 } }
				Behavior on scale { NumberAnimation { duration: 100 } }
				onClicked: root.dashboard.state = "calendar"
			}

			LyxButton {
				id: dashTab
				anchors.bottom: parent.bottom
				property bool activeState: root.dashboard.state === "dash"
				implicitWidth: activeState ? 100 : 90
				implicitHeight: activeState ? 50 : 40
				LyxText {
					anchors.centerIn: parent 
					text: "Dash"
					usePercentSize: true
					percentSize: parent.activeState ? 1.2 : 1.0 
					weightModifier: parent.activeState ? 100 : 0
					color: parent.foregroundColor
				}
				Behavior on implicitWidth { NumberAnimation { duration: 100 } }
				Behavior on implicitHeight { NumberAnimation { duration: 100 } }
				Behavior on scale { NumberAnimation { duration: 100 } }
				onClicked: root.dashboard.state = "dash"
			}

			LyxButton {
				id: launcherTab
				anchors.bottom: parent.bottom
				property bool activeState: root.dashboard.state === "launcher"
				implicitWidth: activeState ? 100 : 90
				implicitHeight: activeState ? 50 : 40
				LyxText {
					anchors.centerIn: parent 
					text: "Launcher"
					usePercentSize: true
					percentSize: parent.activeState ? 1.2 : 1.0 
					weightModifier: parent.activeState ? 100 : 0
					color: parent.foregroundColor
				}
				onClicked: root.dashboard.state = "launcher"
			}

			LyxButton {
				id: wallpapersTab
				anchors.bottom: parent.bottom
				property bool activeState: root.dashboard.state === "wallpapers"
				implicitWidth: activeState ? 100 : 90
				implicitHeight: activeState ? 50 : 40
				LyxText {
					anchors.centerIn: parent 
					text: "Wallpapers"
					usePercentSize: true
					percentSize: parent.activeState ? 1.2 : 1.0 
					weightModifier: parent.activeState ? 100 : 0
					color: parent.foregroundColor
				}
				onClicked: root.dashboard.state = "wallpapers"
			}
		}
	}
}
