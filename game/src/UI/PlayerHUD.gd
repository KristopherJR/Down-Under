extends CanvasLayer

func shift_color(new_color: Color):
	get_node("OxygenHUD/ProgressBar").add_color_override("font_color", new_color)
