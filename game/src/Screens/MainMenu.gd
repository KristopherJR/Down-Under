extends Control

var main_menu = 'res://src/Levels/MainMenu.tscn'
var game_scene = 'res://src/Levels/LevelOne.tscn'

var current_level = 1
var number_of_levels = 1


func restart():
	get_tree().change_scene(main_menu)

func next_level():
	current_level += 1
	if current_level <= number_of_levels:
		get_tree().reload_current_scene()
