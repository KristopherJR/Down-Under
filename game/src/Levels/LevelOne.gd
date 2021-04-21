extends Node2D

var air_timer: = 0.0
var gas_timer: = 300.0 #gas timer set to 5 minutes (300 seconds)

func _physics_process(delta: float) -> void:
	if air_timer < gas_timer:
		air_timer += delta
	print(air_timer)
	if air_timer >= gas_timer:
		get_node("Player").queue_free()
		get_tree().change_scene("res://src/Screens/GameOverScreen.tscn")

