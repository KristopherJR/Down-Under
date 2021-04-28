extends TextureButton

func _ready() -> void:
	$AnimationPlayer.play("sign_bounce")
	

func _on_AnimationPlayer_animation_finished(_anim_name: String) -> void:
	$AnimationPlayer.play("sign_bounce")
