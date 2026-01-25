import QtQuick
import Qt5Compat.GraphicalEffects

Image {
    id: root
    sourceSize.width: width
    sourceSize.height: height
	source: `../../icons/${iconId}`

	required property string iconId
	property color color: "white"

    LyxIconAnimation {
        id: iconSwapAnimation
        target: root
    }

	ColorOverlay {
		anchors.fill: root
		source: root
		color: root.color
	}

    onSourceChanged: iconSwapAnimation.restart()
}
