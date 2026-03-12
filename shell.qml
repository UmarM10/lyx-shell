//@ pragma UseQApplication

import Quickshell
import QtQuick

import qs.modules

ShellRoot {
	id: rootShell

	settings {
		watchFiles: false
	}

	Layout { id: layout }
	Background { id: background }
}
