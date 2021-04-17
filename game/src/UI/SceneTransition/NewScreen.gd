extends CanvasLayer

var scene : String

func change_scene(new_scene):
	scene = new_scene	
	
func _new_scene():
	get_tree().change_scene(scene)
