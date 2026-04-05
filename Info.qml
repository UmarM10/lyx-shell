pragma Singleton

import QtQuick
import Quickshell.Io
import Quickshell

Singleton {
	id: shellInfo

	readonly property url projectRoot: Quickshell.shellDir
	readonly property string currentUser: userCollector.text.slice(0, -1)
	readonly property string configHome: configHomeCollector.text

	Process {
		running: true 
		command: ["whoami"]
		stdout: StdioCollector {
			id: userCollector 
		}
	}
	Process {
		running: true 
		command: ["sh", "~/LyxShell/scripts/get-config-home.sh"]
		stdout: StdioCollector {
			id: configHomeCollector
		}
	}
}
