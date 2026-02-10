pragma Singleton
pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import Quickshell.Bluetooth

Singleton{
    id: root
    
    property var list:!Bluetooth.devices?.values ? [] :
        Bluetooth.devices.values.slice().sort((a, b) =>
            a.connected !== b.connected ? b.connected - a.connected :
            (a.name || "").localeCompare(b.name || "")
    )

    property var pairedDevices: list.filter(device => device.paired)
    property var unpairedDevices: list.filter(device => !device.paired)
    
    property int connectedDevices: list.filter(device => device.state === 1).length
    
    property bool state: Bluetooth.defaultAdapter && Bluetooth.defaultAdapter.enabled ? true : false

	function toggle() {
		Bluetooth.defaultAdapter.enabled = !Bluetooth.defaultAdapter.enabled
	}

	function enable() {
		Bluetooth.defaultAdapter.enabled = true
	}
	function disable() {
		Bluetooth.defaultAdapter.enabled = false
	}
}
