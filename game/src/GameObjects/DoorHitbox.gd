extends Node2D

export var level_path: = 'res://src/Levels/LevelOne.tscn'


func _on_Hitbox_body_entered(body: Node) -> void:
	get_tree().change_scene(level_path)
