extends Actor

export var stomp_impulse: = 1000.0
var death_anim_left: = false #determines if the player is facing left when they die
var health: = 3.0
var isMining = false

func _ready() -> void:
	$AnimatedSprite.play("idle_right")
	
func _on_EnemyDetector_area_entered(_area: Area2D) -> void:
	_velocity = calculate_stomp_velocity(_velocity, stomp_impulse) #make player bounce when it kills enemy

func _on_EnemyDetector_body_entered(_body: Node) -> void:
	health -= 0.5
	$LifeLostPlayer.play(0.0)
	if health == 0:
		$AnimatedSprite.speed_scale = 1.0 #slow  down the animation
		speed = Vector2.ZERO # stop the player moving
		if death_anim_left == true: #if the last input was the player moving left
			$AnimatedSprite.play("death")
			$AnimatedSprite.set_flip_h(true) #play the death animation flipped to the left
		else:
			$AnimatedSprite.play("death") #else play it to the right
		
		yield(get_tree().create_timer(0.75), "timeout") #wait for the death animation to finish
		
		queue_free() #kill character when an enemy touches player
		get_tree().change_scene("res://src/Screens/GameOverScreen.tscn")

func _physics_process(_delta: float) -> void:
	var is_jump_interrupted: = Input.is_action_just_released("jump") and _velocity.y < 0.0
	var direction: = get_direction()
	_velocity = calculate_move_velocity(_velocity, direction, speed, is_jump_interrupted)
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)
	if health > 0:
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
		out.y = (speed.y * direction.y) * 2.75	
	if is_jump_interrupted: #IF player has let go of 'jump' and is falling
		out.y = 0.0
	return out
	
func select_animation() -> void:
	if Input.is_action_just_pressed("move_right"):
		$AnimatedSprite.play("running_right")
		$AnimatedSprite.set_flip_h(false)
		death_anim_left = false #death animation should play right if player dies
	if Input.is_action_just_pressed("move_left"):
		$AnimatedSprite.play("running_right")
		$AnimatedSprite.set_flip_h(true)
		death_anim_left = true #death animation should play left if player dies
		
	if Input.is_action_just_released("move_right"):
		$AnimatedSprite.play("idle_right")
		$AnimatedSprite.set_flip_h(false)
		death_anim_left = false #death animation should play right if player dies
		
	if Input.is_action_just_released("move_left"):
		$AnimatedSprite.play("idle_right")
		$AnimatedSprite.set_flip_h(true)
		death_anim_left = true #death animation should play left if player dies
		
	if Input.is_action_just_pressed("mining"):
		isMining = true
		
	if Input.is_action_just_released("mining"):
		isMining = false
		
func calculate_stomp_velocity(linear_velocity: Vector2, impulse: float) -> Vector2:
	var out: = linear_velocity
	out.y = -impulse
	return out
	
	
	






