// import Quickshell
import QtQuick 
import qs 

Item {
	width: parent.width - 5
	height: 10 

	Rectangle {
		anchors.centerIn: parent 
		anchors.leftMargin: 15
		implicitWidth: parent.width - 15
		implicitHeight: 8
		color: Colors.primaryContainer 
		radius: 15
	}
}
