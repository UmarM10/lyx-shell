//@ pragma UseQApplication

import Quickshell
import Quickshell.Io
import QtQuick

import qs.modules
import qs.modules.wrappers
import qs.config
import qs.services

ShellRoot {
	id: rootShell

	settings {
		watchFiles: false
	}

	OSDWrapper { id: osd }
	Background { id: background }
	Layout { id: layout }
}
