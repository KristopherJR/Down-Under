extends CanvasLayer

func set_visible(is_visible):
		$Node2D.visible = is_visible


func _ready():
	set_visible(false)


func _on_Controls_Info_pressed():
	set_visible(true)

func _on_Exit_pressed():
	set_visible(false)
