extends Node2D

func _on_Hitbox_body_entered(body: Node) -> void:
	body.queue_free() #kill the player
	get_tree().change_scene("res://src/Screens/GameOverScreen.tscn")
	GlobalLevelData.coin_total = 0
