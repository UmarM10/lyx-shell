import QtQuick 
import qs 
import qs.common 
import qs.config

Rectangle {
	id: root 
	implicitWidth: parent.width - 15 
	implicitHeight: childrenHeight + 20 
	property int childrenHeight 
	property bool collapsed: state === "collapsed" ? true : false
	radius: Config.values.cornerRounding * 0.5
	color: Colors.primaryContainer 

	Component.onCompleted: {
		root.childrenHeight = contentItem.childrenRect.height
	}

	default property alias children: contentItem.data
	Item {
		id: contentItem
	}

	LyxButton {
		anchors.right: parent.right 
		anchors.top: parent.top 
		anchors.topMargin: 6
		anchors.rightMargin: 10
		width: 24
		height: 24
		radius: 24
		MaterialIcon {
			id: collapseIcon
			anchors.centerIn: parent 
			iconId: "chevron-down.svg"
			color: parent.foregroundColor 
			scale: parent.foregroundScale
			width: 25 
			height: 25
			rotation: 180
		}
		onClicked: {
			if (root.state === "") { 
				root.state = "collapsed"
			} else {
				root.state = ""
			}
		}
	}

	states: [
		State {
			name: "collapsed"
			PropertyChanges {
				root {
					implicitHeight: 37
				}
				collapseIcon {
					rotation: 0
				}
			}
		}
	]
	transitions: [
		Transition {
			NumberAnimation {
				property: "implicitHeight"
				duration: 200 
				easing.type: Easing.OutExpo
			}
			NumberAnimation {
				property: "rotation"
				duration: 200 
				easing.type: Easing.OutQuad
			}
		}
	]

}
