extends KinematicBody2D

const SPEED = 200
const ACCEL = 0.4

var velocity = Vector2.ZERO
var movement_vector := Vector2.ZERO

var random_number_x = rand_range(-1, 1)
var random_number_y = rand_range(-1, 1)

func _process(delta):
	_move()

func _move():
	movement_vector = _get_movement()
	velocity = move_and_slide(lerp(velocity, movement_vector * SPEED, ACCEL), Vector2.UP)
	
#Function to get the movement
func _get_movement():
	if random_number_x < 0:
		random_number_x = -1
	else:
		random_number_x = 1
	if random_number_y < 0:
		random_number_y = -1
	else:
		random_number_y = 1
		
	movement_vector.x = float(random_number_x)
	movement_vector.y = float(random_number_y)

	return movement_vector.normalized() if movement_vector.length() > 1 else movement_vector
