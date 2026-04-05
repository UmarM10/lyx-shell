pragma Singleton 

import Quickshell 
import Quickshell.Io
import QtQuick 

Singleton {
	property real cpuUsagePercent: cpuUsageCollector.text
	property real gpuUsagePercent: nvidiaGpuUsageCollector.text ? nvidiaGpuUsageCollector.text : amdGpuUsageCollector.text
	property real ramUsagePercent: ramUsageCollector.text

	Timer {
		id: dataUpdater 
		interval: 1500
		running: true 
		repeat: true
		onTriggered: {
			cpuUsageProc.running = false;
			cpuUsageProc.running = true; 
			nvidiaGpuUsageProc.running = false;
			nvidiaGpuUsageProc.running = true; 
			amdGpuUsageProc.running = false;
			amdGpuUsageProc.running = true; 
			ramUsageProc.running = false;
			ramUsageProc.running = true;
		}
	}

	Process {
		id: cpuUsageProc
		running: true
		command: ["sh", "-c", "mpstat 1 1 | awk '/Average:/ {print 100 - $NF}' | head -c 3"]
		stdout: StdioCollector { id: cpuUsageCollector }
	}

	Process {
		id: nvidiaGpuUsageProc 
		running: true
		command: ["sh", "-c", "nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits"]
		stdout: StdioCollector { id: nvidiaGpuUsageCollector }
	}
	Process {
		id: amdGpuUsageProc 
		running: true
		command: ["sh", "-c", "cat /sys/class/drm/card0/device/gpu_busy_percent"]
		stdout: StdioCollector { id: amdGpuUsageCollector }
	}

	Process {
		id: ramUsageProc 
		running: true
		command: ["sh", "-c", "free | awk '/^Mem/ {printf((1 - $7/$2) * 100)}' | head -c -5"]
		stdout: StdioCollector { id: ramUsageCollector }
	}
}
