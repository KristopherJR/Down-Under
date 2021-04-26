extends Node2D

export var spawn_location: = Vector2.ZERO
	
func _ready() -> void:
	$AudioStreamPlayer.play(0.0) #play the song at the start of the level
	
	spawn_location = GlobalLevelData.spawn_location
	
	$Player.position = spawn_location
	
	GlobalLevelData.spawn_location = Vector2(235.298,1043.18)

func _on_AudioStreamPlayer_finished() -> void:
	$AudioStreamPlayer.play(0.0) #loops the song when it's finished

func _fade_music() -> void:
	$AnimationPlayer.play("fade_music")
	
func _on_Area2D_body_entered(_body: Node) -> void:
	_fade_music()
	

	
