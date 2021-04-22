extends Actor

export var stomp_impulse: = 1000.0

func _on_EnemyDetector_area_entered(_area: Area2D) -> void:
	_velocity = calculate_stomp_velocity(_velocity, stomp_impulse) #make player bounce when it kills enemy

func _on_EnemyDetector_body_entered(_body: Node) -> void:
	queue_free() #kill character when an enemy touches player

func _physics_process(_delta: float) -> void:
	var is_jump_interrupted: = Input.is_action_just_released("jump") and _velocity.y < 0.0
	var direction: = get_direction()
	_velocity = calculate_move_velocity(_velocity, direction, speed, is_jump_interrupted)
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)
	select_animation()
		
func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 0.0
	)

func calculate_move_velocity(
		linear_velocity: Vector2,
		direction: Vector2,
		speed: Vector2,
		is_jump_interrupted: bool
	) -> Vector2:
	var out: = linear_velocity #SET out to the current velocity
	out.x = speed.x * direction.x 
	out.y += gravity * get_physics_process_delta_time() #ADD gravity to the player
	if direction.y == -1.0: #PLAYER has hit 'jump'
		out.y = (speed.y * direction.y) * 2	
	if is_jump_interrupted: #IF player has let go of 'jump' and is falling
		out.y = 0.0
	return out
	
func select_animation() -> void:
	if Input.is_action_just_pressed("move_right"):
		$AnimatedSprite.play("running_right")
		$AnimatedSprite.set_flip_h(false)
		
	if Input.is_action_just_pressed("move_left"):
		$AnimatedSprite.play("running_right")
		$AnimatedSprite.set_flip_h(true)
		
	if Input.is_action_just_released("move_right"):
		$AnimatedSprite.play("idle_right")
		$AnimatedSprite.set_flip_h(false)
		
	if Input.is_action_just_released("move_left"):
		$AnimatedSprite.play("idle_right")
		$AnimatedSprite.set_flip_h(true)
		
func calculate_stomp_velocity(linear_velocity: Vector2, impulse: float) -> Vector2:
	var out: = linear_velocity
	out.y = -impulse
	return out
	

func _input(event):
	if event.is_action_pressed("pickup"):
		if $PickupZone.items_in_range.size() > 0:
			var pickup_item = $PickupZone.items_in_range.values()[0]
			pickup_item.pick_up_item(self)
			$PickupZone.items_in_range.erase(pickup_item)
