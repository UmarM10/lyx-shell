// Get Background Color
function getBackgroundColor() {
}
// Get Border Color
function getBorderColor() {
	if (mouseArea.containsMouse)
		return Colors.secondary
	else
		return Colors.primaryContainer
}
