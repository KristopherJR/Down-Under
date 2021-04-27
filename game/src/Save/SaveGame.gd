extends Node2D

const SAVE_DIR = "user://game_saves/"
var save_path = SAVE_DIR + "save.dat"
onready var Location = get_node("Actor")

func _on_SaveGame_pressed():
	var data = {
		"location" : Location._velocity
	}
	
	var dir = Directory.new()
	if !dir.dir_exists(SAVE_DIR):
		dir.make_dir_recursive(SAVE_DIR)
	
	var file = File.new()
	var error = file.open_encrypted_with_pass(save_path, File.WRITE, "Down4Under")
	if error == OK:
		file.store_var(data)
		file.close()
	
	print("Game Saved")



func _on_LoadGame_pressed():
	var file = File.new()
	if file.file_exists(save_path):
		var error = file.open_encrypted_with_pass(save_path, File.READ, "Down4Under")
		if error == OK:
			var player_data = file.get_var()
			file.close()
			print (player_data)
	
	print("Game Loaded")
