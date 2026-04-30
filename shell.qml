//@ pragma UseQApplication

import Quickshell
import Quickshell.Io
import QtQuick

import qs.modules
import qs.modules.panels
import qs.config
import qs.services

ShellRoot {
	id: rootShell

	settings {
		watchFiles: false
	}

	Background { id: background }
	Layout { id: layout }
	OSDPanel { id: osd }
	DashboardPanel { id: dashboard }
}
