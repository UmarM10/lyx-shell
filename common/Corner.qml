import QtQuick
import QtQuick.Shapes

import qs

Shape {
	id: root 

	required property Item target
	required property string corner
	property real radius: 20
	property color color: Colors.background
	// Whether the corner is outside the target edge or not
	// property bool outside

	width: radius
	height: radius
	z: 99
	antialiasing: true
	layer.enabled: true
	layer.samples: 20

	visible: target.visible
	opacity: target.opacity

	// anchors.top: {
	// 	switch(corner) {
	// 		case "topLeft": return undefined
	// 		case "topRight": return undefined
	// 		case "bottomLeft": return target.bottom
	// 		case "bottomRight": return target.bottom
	// 	}
	// }
	// anchors.right: {
	// 	switch(corner) {
	// 		case "topLeft": return undefined
	// 		case "topRight": return target.left
	// 		case "bottomLeft": return undefined
	// 		case "bottomRight": return undefined
	// 	}
	// }	
	// anchors.bottom: {
	// 	switch(corner) {
	// 		case "topLeft": return target.top
	// 		case "topRight": return target.top
	// 		case "bottomLeft": return target.bottom
	// 		case "bottomRight": return target.bottom
	// 	}
	// }
	// anchors.left: {
	// 	switch(corner) {
	// 		case "topLeft": return target.left
	// 		case "topRight": return undefined
	// 		case "bottomLeft": return target.left
	// 		case "bottomRight": return target.right
	// 	}
	// }

	rotation: {
        switch(corner) {
            case "topLeft": return 90      // Pointing Bottom-Left
            case "topRight": return 180    // Pointing Bottom-Right
            case "bottomRight": return 270  // Pointing Top-Right
            case "bottomLeft": return 0    // Pointing Top-Left (Default)
            default: return 0
        }
    }
	
	ShapePath {
		id: path
		fillColor: root.color 
		strokeWidth: 0 

		startX: 0
		startY: 0

        PathLine {
			x: 0
			y: root.radius
        }
        PathLine {
			x: root.radius
			y: root.radius
        }

		PathArc {
			x: 0 
			y: 0
            radiusX: root.radius
            radiusY: root.radius

			direction: PathArc.Clockwise
		}
	}
}
