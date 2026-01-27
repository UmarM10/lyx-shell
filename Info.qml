pragma Singleton

import QtQuick

Item {
	id: projectInfo

	readonly property url projectRoot: Qt.resolvedUrl(".")
}
