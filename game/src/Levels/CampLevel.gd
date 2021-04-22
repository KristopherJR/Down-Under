extends Node2D

func _ready() -> void:
	$AudioStreamPlayer.play(0.0) #play the song at the start of the level

func _on_AudioStreamPlayer_finished() -> void:
	$AudioStreamPlayer.play(0.0) #loops the song when it's finished

func _fade_music() -> void:
	$AnimationPlayer.play("fade_music")
	
func _on_Area2D_body_entered(body: Node) -> void:
	_fade_music()
