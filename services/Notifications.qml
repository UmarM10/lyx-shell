pragma Singleton

import Quickshell
import Quickshell.Services.Notifications
import QtQuick 

Singleton {
	property var server: server
	NotificationServer { 
		id: server 
		actionsSupported: true

		property var notificationDateTimes: []
		
		onNotification: (notification) => {
			if (!notification.transient) {
				notificationDateTimes.push(new Date());
				notification.tracked = true;
			}
		}

	}
}
