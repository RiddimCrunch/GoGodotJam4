extends KinematicBody2D

const SPEED = 200
const ACCEL = 0.5

var velocity = Vector2.ZERO
var input_vector
var screen_size

func _physics_process(_delta):
	_moveAction()

func _moveAction():
	input_vector = _getInput()
	velocity = move_and_slide(lerp(velocity, input_vector * SPEED, ACCEL), Vector2.UP)

func _getInput():
	input_vector = Vector2.ZERO
	input_vector.x = float(Input.is_action_pressed("right")) - float(Input.is_action_pressed("left"))
	input_vector.y = float(Input.is_action_pressed("down")) - float(Input.is_action_pressed("up"))

	return input_vector.normalized() if input_vector.length() > 1 else input_vector
