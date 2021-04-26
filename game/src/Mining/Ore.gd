extends StaticBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

enum {INRANGE, NOTRANGE}	# initialize the states for the Ore
var state = NOTRANGE		# initialize initial state for the Ore

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if event.is_action_pressed("mining"):
		if state == INRANGE:
			# Insert here features that are wanted after mining
			queue_free() # delete the Ore node

func _on_MinableMaterial_body_entered(body):
	# when the player enters the body of the ore, change the state to 'INRANGE'
	if body.is_in_group("Player"):
		state = INRANGE

func _on_MinableMaterial_body_exited(body):
	# when the player leaves the body of the ore, change the state to 'NOTRANGE'
	if body.is_in_group("Player"):
		state = NOTRANGE
