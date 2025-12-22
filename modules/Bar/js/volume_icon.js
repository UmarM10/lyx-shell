// Volume Icon Logic
function getAudioIconPath() {
	if (!Pipewire.defaultAudioSink.audio)
		return "../../icons/volume-xmark-solid-full.svg";
	else if (Pipewire.defaultAudioSink.audio.muted) {
		return "../../icons/volume-xmark-solid-full.svg";
	} else if (Pipewire.defaultAudioSink.audio.volume >= 0.75) {
		return "../../icons/volume-high-solid-full.svg";
	} else if (Pipewire.defaultAudioSink.audio.volume >= 0.50) {
		return "../../icons/volume-low-solid-full.svg";
	} else if (Pipewire.defaultAudioSink.audio.volume >= 0.25) {
		return "../../icons/volume-low-solid-full.svg";
	} else {
		return "../../icons/volume-off-solid-full.svg";
	}
}

// Get Background Color
function getBackgroundColor() {
	if (mouseArea.containsMouse)
		return Colors.primary;
	else
		return "transparent";
}

// Get Foreground Color
function getForegroundColor() {
	if (mouseArea.containsMouse)
		return Colors.background;
	else
		return Colors.primary;
}
