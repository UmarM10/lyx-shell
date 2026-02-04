pragma Singleton

import Quickshell
import Quickshell.Services.UPower
import QtQuick

Singleton {
	property QtObject defaultBattery: UPower.displayDevice
	property string iconId: getIconId()

	function getIconId() {
		if (UPower.displayDevice.state == UPowerDeviceState.Unknown)
			return "brightness-7.svg";
		else if (UPower.displayDevice.percentage >= 0.875) {
			return "battery-full.svg";
		} else if (UPower.displayDevice.percentage >= 0.75) {
			return "battery-6.svg";
		} else if (UPower.displayDevice.percentage >= 0.625) {
			return "battery-5.svg";
		} else if (UPower.displayDevice.percentage >= 0.50) {
			return "battery-4.svg";
		} else if (UPower.displayDevice.percentage >= 0.375) {
			return "battery-3.svg";
		} else if (UPower.displayDevice.percentage >= 0.25) {
			return "battery-2.svg";
		} else if (UPower.displayDevice.percentage >= 0.125) {
			return "battery-1.svg";
		} else if (UPower.displayDevice.percentage >= 0 && UPower.displayDevice.state == UPowerDeviceState.Discharging) {
			return "battery-alert.svg";
		} else if (UPower.displayDevice.percentage >= 0) {
			return "battery-0.svg";
		} else {
			return "brightness-7.svg";
		}
	}
}
