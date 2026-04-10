import QtQuick
import qs.config

import qs

Text {
	property real percentSize: 1.0
	property bool usePercentSize: false
	property int weightModifier: 0

	font.family: Config.values.fontFace
	font.weight: Config.values.fontWeight + weightModifier
	font.pixelSize: usePercentSize ? percentSize * Config.values.fontPixelSize : Config.values.fontPixelSize
	color: Colors.primary
}
