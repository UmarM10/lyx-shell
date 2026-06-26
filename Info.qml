pragma Singleton

import QtQuick
import Quickshell.Io
import Quickshell

Singleton {
	id: shellInfo

	readonly property url projectRoot: Quickshell.shellDir
	readonly property string currentUser: Quickshell.env("USER")
	readonly property string currentHome: Quickshell.env("HOME")
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
