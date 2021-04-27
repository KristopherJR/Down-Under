extends Control

func _ready() -> void:
	$AudioStreamPlayer.play(0.0) #play the song at the start of the level
	
func _on_AudioStreamPlayer_finished() -> void:
	$AudioStreamPlayer.play(0.0) #loops the song when it's finished
