extends CanvasLayer

func set_visible(is_visible):
	$CaveRulesNode.visible = is_visible


func _ready():
	set_visible(false)


func _on_CaveRulesBtn_pressed():
	set_visible(true)

func _on_Exit_pressed():
	set_visible(false)


