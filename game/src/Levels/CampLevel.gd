extends Node2D

#kills worm if bounce on head
func _on_DoorHitbox_body_entered(body: Node) -> void:
	if body.global_position.y > get_node("DoorHitbox").global_position.y:
		SceneChanger.change_scene('res://src/Levels/LevelOne.tcsn')
