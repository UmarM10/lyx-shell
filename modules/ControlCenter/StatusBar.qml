import QtQuick
import qs
import qs.common

Rectangle {
    id: root
    implicitWidth: parent.implicitWidth
    implicitHeight: 20
    color: "transparent"

    property bool draggable: false
	property bool dragUpdatesImmediately: true
	property var displayValue: 0.0
	property string sliderText: ""
    property string iconId
    signal iconClicked
	signal valueUpdatedByDragging(real newValue)

	LyxButton {
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: 3
        implicitWidth: 23
        implicitHeight: 23
        radius: 20
        MaterialIcon {
            anchors.centerIn: parent
            width: 21
            height: 21
            iconId: root.iconId
            color: parent.foregroundColor
            scale: parent.foregroundScale
        }
		onClicked: {
			root.iconClicked()
		}
    }

	Slider {
		draggable: root.draggable
		displayValue: root.displayValue 
		onValueUpdatedByDragging: (newValue) => root.valueUpdatedByDragging(newValue)
		updateImmediately: root.dragUpdatesImmediately

		LyxText {
			anchors.verticalCenter: parent.verticalCenter
			anchors.right: parent.right 
			anchors.rightMargin: 2
			text: root.sliderText
			color: Colors.primary
			font.pixelSize: 12 
			opacity: 0.6
		}
	}
}
