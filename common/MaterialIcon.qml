import QtQuick
import Qt5Compat.GraphicalEffects

import qs

Image {
    id: root
    sourceSize.width: width
    sourceSize.height: height
	source: `${Info.projectRoot}/assets/${iconId}`

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
	onVisibleChanged: iconSwapAnimation.restart()
}
