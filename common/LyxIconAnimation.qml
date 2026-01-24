import QtQuick

SequentialAnimation {
	required property var target
	id: animationRoot
	
	NumberAnimation {
		target: animationRoot.target
		property: "scale"
		to: 0.75
		duration: 75
		easing.type: Easing.OutQuad
	}

	PauseAnimation {
		duration: 50
	}

	NumberAnimation {
		target: animationRoot.target
		property: "scale"
		to: 1.0
		duration: 100
		easing.type: Easing.OutQuad
	}
}
