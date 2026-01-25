// Volume Icon Logic
function getAudioIconPath() {
	if (!Pipewire.defaultAudioSink.audio)
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
