extends Node2D

export(float) var maxSpeed: = 100.0
export(float) var minSpeed: = 80.0

export(float) var cohesion: = 2.0
export(float) var alignment: = 3.0
export(float) var separation: = 5.0

export(float) var viewDistance: = 50.0
export(float) var avoidDistance: = 15.0

export(int) var maxFlockSize: = 15
export(float) var targetForce: = 2.0
export(float) var screenAvoidForce: = 10.0

onready var screenSize = get_viewport_rect().size

var targets = []
var velocity: Vector2
var stayOnScreen: = true
var flock = []
var flockSize: int = 0
var screenAvoidVector
var vectors
var acceleration
var targetVector
var cohesionVector
var alignVector
var separationVector
var centerVector
var flockCenter
var avoidVector
var otherCount
var otherPosition: Vector2
var otherVelocity: Vector2
var distance
var edgeAvoidVector

func _ready():
	randomize()
	velocity = Vector2(rand_range(-1, 1), rand_range(-1, 1)).normalized() * maxSpeed


func process(delta):
	position += velocity * delta
	screenAvoidVector = Vector2.ZERO

	if stayOnScreen:
		screenAvoidVector = _avoidScreenEdge() * screenAvoidForce
	else:
		_wrapScreen()

	vectors = _getFlockStatus()

	cohesionVector = vectors[0] * cohesion
	alignVector = vectors[1] * alignment
	separationVector = vectors[2] * separation
	flockSize = vectors[3]
	acceleration = alignVector + cohesionVector + separationVector + screenAvoidVector
	
	if targets:
		targetVector = Vector2.ZERO

		for target in targets:
			targetVector += global_position.direction_to(target)

		targetVector /= targets.size()
		acceleration += targetVector * targetForce

	velocity = (velocity + acceleration).clamped(maxSpeed)

	if velocity.length() <= minSpeed:
		velocity = (velocity * minSpeed).clamped(maxSpeed)
		
	look_at(global_position + velocity)


func _getFlockStatus():
	centerVector = Vector2()
	flockCenter = Vector2()
	alignVector = Vector2()
	avoidVector = Vector2()
	otherCount = 0

	for cell in flock:
		for other in cell:
			if otherCount == maxFlockSize:
				break

			if other == self:
				continue

			otherPosition = other.global_position
			otherVelocity = other.velocity

			if global_position.distance_to(otherPosition) < viewDistance:
				otherCount += 1
				alignVector += otherVelocity
				flockCenter += otherPosition

				distance = global_position.distance_to(otherPosition)

				if distance < avoidDistance:
					avoidVector -= otherPosition - global_position

	if otherCount:
		alignVector /= otherCount
		flockCenter /= otherCount
		centerVector = global_position.direction_to(flockCenter)

	return [centerVector.normalized(), alignVector.normalized(), avoidVector.normalized(), otherCount]




func _avoidScreenEdge():
	edgeAvoidVector = Vector2.ZERO

	if position.x - avoidDistance < 0:
		edgeAvoidVector.x = 1
	elif position.x + avoidDistance > screenSize.x:
		edgeAvoidVector.x = -1

	if position.y - avoidDistance < 0:
		edgeAvoidVector.y = 1
	elif position.y + avoidDistance > screenSize.y:
		edgeAvoidVector.y = -1

	return edgeAvoidVector.normalized()


func _wrapScreen():
	position.x = wrapf(position.x, 0, screenSize.x)
	position.y = wrapf(position.y, 0, screenSize.y)

func setValue(params: Dictionary):
	for param in params.keys():
		set(param, params[param])

func setSpeed(value: float):
	maxSpeed = value

func setCohesion(value: float):
	cohesion = value

func setAlignment(value: float):
	alignment = value

func setSeparation(value: float):
	separation = value
