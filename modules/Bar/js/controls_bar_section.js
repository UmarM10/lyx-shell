// Volume Icon Logic
function getAudioIconPath() {
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

// Battery Icon Logic
function getBatteryIconPath() {
	if (UPower.displayDevice.state == UPowerDeviceState.Unknown)
		return "brightness-7.svg";
	else if (UPower.displayDevice.percentage >= 87.5) {
		return "battery-full.svg";
	} else if (UPower.displayDevice.percentage >= 75) {
		return "battery-6.svg";
	} else if (UPower.displayDevice.percentage >= 62.5) {
		return "batter-5.svg";
	} else if (UPower.displayDevice.percentage >= 50) {
		return "battery-4.svg";
	} else if (UPower.displayDevice.percentage >= 37.5) {
		return "battery-3.svg";
	} else if (UPower.displayDevice.percentage >= 25) {
		return "battery-2.svg";
	} else if (UPower.displayDevice.percentage >= 12.5) {
		return "battery-1.svg";
	} else if (UPower.displayDevice.percentage >= 0 && UPower.displayDevice.state == UPowerDeviceState.Discharging) {
		return "battery-alert.svg";
	} else if (UPower.displayDevice.percentage >= 0) {
		return "battery-0.svg";
	} else {
		return "brightness-7.svg";
	}
}
