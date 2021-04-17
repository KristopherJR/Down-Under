extends Control

onready var spin_box: SpinBox = $SpinBox
onready var game_saver: Node = $SaveGame

func _on_SaveGame_pressed():
	game_saver.save(spin_box.value)


func _on_LoadGame_pressed():
	game_saver.load(spin_box.value)
