import QtQuick

import qs.common
// import "js/notifications_icon.js" as Logic

LyxButton {
    id: root
    anchors.horizontalCenter: parent.horizontalCenter
    implicitHeight: 25.5
    implicitWidth: 30

    MaterialIcon {
        id: notificationsIcon
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        height: 21
        width: 21
		iconId: "bell-solid-full.svg"
		color: root.foregroundColor
    }
}
