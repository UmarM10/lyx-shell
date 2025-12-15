import Quickshell
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

import "../.."

Button {
	id: volumeIconBox
	background: Rectangle {
		color: "transparent" 
		anchors.horizontalCenter: parent.horizontalCenter
	}
	anchors.horizontalCenter: parent.horizontalCenter
	padding: 0

	contentItem: Image {
		id: volumeIcon
		anchors.horizontalCenter: parent.horizontalCenter
		height: 21
		width: 21
		sourceSize.width: 21 
		sourceSize.height: 21 

		// Animation
		SequentialAnimation {
			id: volumeIconAnimation
			NumberAnimation {
				target: volumeIcon
				property: "scale"
				to: 0.75
				duration: 75
				easing.type: Easing.OutQuad
			}

			PauseAnimation {
				duration: 50
			}

			NumberAnimation {
				target: volumeIcon
				property: "scale"
				to: 1.0
				duration: 100
				easing.type: Easing.OutQuad
			}
		}
		onSourceChanged: {
			volumeIconAnimation.restart();
		}

		PwObjectTracker {
			objects: Pipewire.nodes.values
		}
		property var activeSink: Pipewire.defaultAudioSink.audio
		function getAudioIconPath() {
			if (!activeSink)
				return "../../icons/volume-xmark-solid-full.svg";
			else if (activeSink.muted) {
				return "../../icons/volume-xmark-solid-full.svg";
			} else if (activeSink.volume >= 0.75) {
				return "../../icons/volume-high-solid-full.svg";
			} else if (activeSink.volume >= 0.50) {
				return "../../icons/volume-low-solid-full.svg";
			} else if (activeSink.volume >= 0.25) {
				return "../../icons/volume-low-solid-full.svg";
			} else {
				return "../../icons/volume-off-solid-full.svg";
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
