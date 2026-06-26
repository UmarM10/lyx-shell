//@ pragma UseQApplication

import Quickshell
import Quickshell.Io
import QtQuick

import qs.modules 
import qs.modules.ScreenBorder
import qs.modules.OSD 
import qs.modules.Dashboard
import qs.modules.ControlCenter 
import qs.modules.Bar

import qs.config
import qs.services

ShellRoot {
    id: rootShell

    settings {
        watchFiles: false
    }

    Background {
        id: background
    }
    ScreenBorder {
        id: layout
    }
    OSDPanel {
        id: osd
    }
	DashboardPanel {
        id: dashboard
    }
    ControlCenterPanel {
        id: controlCenterPanel
    }
    Bar {
        id: bar
        screen: Quickshell.screens[0]
        controlCenter: controlCenterPanel.controlCenter
    }
}
