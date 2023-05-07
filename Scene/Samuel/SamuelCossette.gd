extends KinematicBody2D

const SPEED = 200
const ACCEL = 0.4


var location = Vector2.ZERO
var velocity = Vector2.ZERO
var input_vector := Vector2.ZERO

func _ready():
	pass # Replace with function body.

func _process(delta):
	_move_action()
	
#Function to move the player
func _move_action():
	input_vector = _get_input()
	velocity = move_and_slide(lerp(velocity, input_vector * SPEED, ACCEL), Vector2.UP)
	
#Function to get the player input
func _get_input():
	input_vector.x = float(Input.is_action_pressed("ui_right")) - float(Input.is_action_pressed("ui_left"))
	input_vector.y = float(Input.is_action_pressed("ui_down")) - float(Input.is_action_pressed("ui_up"))

	return input_vector.normalized() if input_vector.length() > 1 else input_vector
