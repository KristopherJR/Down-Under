extends KinematicBody2D
class_name Actor

export var speed: = Vector2(3000.0, 1000.0)
export var gravity: = 300.0

var velocity: = Vector2.ZERO

func _physics_process(delta):
	velocity.y += gravity * delta #accelerates gravity by time elapsed since last frame call
	
