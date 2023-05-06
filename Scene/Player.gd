extends KinematicBody2D

# Player script for top-down shooter

var motion = Vector2()
export var speed = 500
export var acceleration = .5
export var friction  = 0.05

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Function that manage the inputs from the player
func get_input():

	var input = Vector2()
	input.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

	return input


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var direction = get_input()
	direction = direction.normalized()

	if direction.length() > 0:		
		motion = motion.linear_interpolate(direction.normalized() * speed, acceleration)
	else :
		motion = motion.linear_interpolate(Vector2(), friction)
	
	motion = move_and_slide(motion)
	
	look_at(get_global_mouse_position())
		