// Get Background Color
function getBackgroundColor() {
	if (mouseArea.containsMouse)
		return Colors.primary;
	else
		return "transparent";
}

// Get Foreground Color
function getForegroundColor() {
	if (mouseArea.containsMouse)
		return Colors.background;
	else
		return Colors.primary;
}
