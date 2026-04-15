pragma Singleton 

import Quickshell 
import Quickshell.Services.UPower
import QtQuick 

Singleton {
	id: root
	property bool hasPerformanceMode: PowerProfiles.hasPerformanceProfile
	readonly property string currentProfile: {
		if (PowerProfiles.profile === PowerProfile.PowerSaver) return "Power Saver"
		if (PowerProfiles.profile === PowerProfile.Balanced) return "Balanced"
		if (PowerProfiles.profile === PowerProfile.Performance) return "Performance"
		return "Unknown"
	}

	function set(profile) {
		switch (profile) {
			case "powerSaver": {
				PowerProfiles.profile = PowerProfile.PowerSaver;
				break;
			} case "balanced": {
				PowerProfiles.profile = PowerProfile.Balanced;
				break;
			} case "performance": {
				PowerProfiles.profile = PowerProfile.Performance;
				break;
			}
		}
	}
}
