import QtQuick
import qs

Rectangle {
	id: root

	property string orientation: "horizontal"
	property int thickness: 2

	implicitWidth: orientation == "horizontal" ? parent.width / 1.15 : thickness
	implicitHeight: orientation == "vertical" ? parent.width / 1.15 : thickness

	// Default
	color: Colors.outlineVariant
	radius: 25
}
