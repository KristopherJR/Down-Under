extends Actor


func _ready() -> void:
	set_physics_process(false)
	_velocity.x = -speed.x


func _physics_process(delta: float) -> void:
	_velocity.y += gravity * delta
	if is_on_wall():
		_velocity.x *= -1.0
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y
	select_animation(_velocity)


func select_animation(
		_velocity: Vector2
	) -> void:
	
	$AnimatedSprite.play("wiggle_right")
	if _velocity.x > 0.0:
		$AnimatedSprite.set_flip_h(false)
	if _velocity.x < 0.0:
		$AnimatedSprite.set_flip_h(true)
