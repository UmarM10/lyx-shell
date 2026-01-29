pragma Singleton

import QtQuick

Item {
	id: shellInfo

	readonly property url projectRoot: Qt.resolvedUrl(".")
}
