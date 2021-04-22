extends Node2D

var air_timer: = 0.0
var gas_timer: = 300.0 #gas timer set to 5 minutes (300 seconds)

func _ready() -> void:
	$AudioStreamPlayer.play(0.0) #play the song at the start of the level

func _physics_process(delta: float) -> void:
	if air_timer < gas_timer:
		air_timer += delta
	print(air_timer)
	if air_timer >= gas_timer:
		get_node("Player").queue_free() #kill the player when they run out of time
		get_tree().change_scene("res://src/Screens/GameOverScreen.tscn")

func _on_AudioStreamPlayer_finished() -> void:
	$AudioStreamPlayer.play(0.0) #loops the song when it's finished

func _on_MusicFadeArea_body_entered(body: Node) -> void:
	$AnimationPlayer.play("music_fade_in")
