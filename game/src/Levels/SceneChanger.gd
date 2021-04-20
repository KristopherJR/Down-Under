extends Node

#code from https://www.youtube.com/watch?v=_4_DVbZwmYc

signal scene_changed()

onready var animation_player = $AnimationPlayer
onready var black_fade = $Control/BlackFade

func change_scene(path, delay = 0.5):
	yield(get_tree().create_timer(delay), "timeout")
	animation_player.play("fade_out")
	yield(animation_player, "animation_finished")
	assert(get_tree().change_scene(path) == OK)
	animation_player.play_backwards("fade_out")
	emit_signal("scene_changed")
	
