extends Actor


func _ready() -> void:
	set_physics_process(false) #deactivate enemy at start of game
	speed.x = 150
	_velocity.x = -speed.x
	
#kills worm if bounce on head
func _on_StompDetector_body_entered(body: Node) -> void:
	if body.global_position.y > get_node("StompDetector").global_position.y:
		return
	get_node("CollisionShape2D").set_deferred("disabled",true) #turns off enemy collider so you can't die if you bounce on it
	queue_free() #kills the worm


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



