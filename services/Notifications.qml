pragma Singleton

import Quickshell
import Quickshell.Services.Notifications
import QtQuick 

Singleton {
	property var server: server
	NotificationServer { 
		id: server 
		onNotification: (notification) => {
			notification.tracked = true
		}
	}
}
