extends Node2D

signal picked_up()

func _ready() -> void:
	add_to_group("coins")
	
func _on_CoinHitbox_body_entered(body: Node) -> void:
	if body.name == "Player":
		emit_signal("picked_up")
		$AnimationPlayer.play("coin_collect")
		$AudioStreamPlayer.play(0.0)
		yield($AnimationPlayer,"animation_finished")
		queue_free()
