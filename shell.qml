//@ pragma UseQApplication

import Quickshell
import Quickshell.Io
import QtQuick

import qs.modules
import qs.config
import qs.services

ShellRoot {
	id: rootShell

	settings {
		watchFiles: false
	}

	Layout { id: layout }
	Background { id: background }
}
