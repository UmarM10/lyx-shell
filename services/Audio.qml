pragma Singleton

import Quickshell
import Quickshell.Services.Pipewire
import QtQuick

Singleton {
	PwObjectTracker {
		objects: Pipewire.nodes.values
	}

	property QtObject defaultSink: Pipewire.defaultAudioSink
	property QtObject defaultSinkAudio: Pipewire.defaultAudioSink ? Pipewire.defaultAudioSink.audio : null
	property string iconId: getIconId()

	function getIconId() {
		if (!Pipewire.defaultAudioSink)
			return "volume-xmark-solid-full.svg";
		else if (Pipewire.defaultAudioSink.audio.muted) {
			return "volume-xmark-solid-full.svg";
		} else if (Pipewire.defaultAudioSink.audio.volume >= 0.75) {
			return "volume-high-solid-full.svg";
		} else if (Pipewire.defaultAudioSink.audio.volume >= 0.50) {
			return "volume-low-solid-full.svg";
		} else if (Pipewire.defaultAudioSink.audio.volume >= 0.25) {
			return "volume-low-solid-full.svg";
		} else {
			return "volume-off-solid-full.svg";
		}
	}
}
