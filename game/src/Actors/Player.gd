extends Actor


func _physics_process(delta: float) -> void:
	var direction: = get_direction()
	velocity = calculate_move_velocity(velocity, direction, speed)
	velocity = move_and_slide(velocity, FLOOR_NORMAL)
	select_animation()
	
	
func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 1.0
	)
	
	
func calculate_move_velocity(
		linear_velocity: Vector2,
		direction: Vector2,
		speed: Vector2
	) -> Vector2:
	var new_velocity: = linear_velocity
	new_velocity.x = speed.x * direction.x
	new_velocity.y += gravity * get_physics_process_delta_time()
	if direction.y == -1.0:
		new_velocity.y = speed.y * direction.y
	return new_velocity
	
func select_animation() -> void:
	if Input.is_action_just_pressed("move_right"):
		$AnimatedSprite.play("running_right")
	if Input.is_action_just_pressed("move_left"):
		$AnimatedSprite.play("running_left")
	if Input.is_action_just_released("move_left"):
		$AnimatedSprite.play("idle_left")
	if Input.is_action_just_released("move_right"):
		$AnimatedSprite.play("idle_right")
	
	
