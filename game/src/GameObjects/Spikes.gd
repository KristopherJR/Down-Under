extends Node2D

func _on_Hitbox_body_entered(body: Node) -> void:
	body.queue_free() #kill the player
