extends Node2D

export var level_path: = 'res://src/Levels/LevelOne.tscn'

func _on_Hitbox_body_entered(_body: Node) -> void:
	$AnimationPlayer.play("fade") #play the fade animation
	yield($AnimationPlayer, "animation_finished") #wait for the animation to finish
	get_tree().change_scene(level_path) # change the level
