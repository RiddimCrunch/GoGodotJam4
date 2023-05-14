extends Node2D

export(int) var startingBoids = 20
export(PackedScene) var Boid 
export(int) var groups = 4

const BoidStructure = preload("res://Scene/Samuel/Boid/BoidStructure.gd")
var boidStructure: BoidStructure

onready var screenSize: = get_viewport_rect().size
onready var scaledPoints = range(startingBoids)

var boid
var boids = []
var initPosition
var structureScale
var scaledPoint
var start
var end
var initBoidBValue
var color = Color(86, 0, 144)

func _ready():
	_initBoids()

func _process(delta):
	_buildStructure()
	_updateBoids()
	_processBoids(delta)
	$Boids.modulate = color

func _initBoids():
	initBoidBValue = $"../UI"._getCurrentValues()
	for i in startingBoids:
		randomize()
		boid = Boid.instance()
		initPosition = Vector2(rand_range(0, screenSize.x), rand_range(0, screenSize.y))
		boid.position = initPosition
		boid.add_to_group("boids")
		boid.setValue(initBoidBValue)
		boids.append(boid)
		$Boids.add_child(boid)


func _buildStructure():
	structureScale = floor(boids[0].viewDistance / 2)
	boidStructure = BoidStructure.new(screenSize, structureScale)

	for i in boids.size():
		scaledPoint = boidStructure._scalePoint(boids[i].position)
		boidStructure._addBody(boids[i], scaledPoint)
		scaledPoints[i] = scaledPoint


func _updateBoids():
	for i in boids.size():
		boids[i].flock = boidStructure._getBodies(scaledPoints[i])


func _processBoids(delta):
	for group in groups:
		_processGroupBoid({"delta": delta, "group": group})


func _processGroupBoid(data):
	start = boids.size() / groups * data.group
	end = start + boids.size() / groups

	if data.group == groups - 1:
		end += boids.size() % groups

	for i in range(start, end):
		boids[i].process(data.delta)

func setColor(value: Color):
	color = value


func _on_Color_color_changed(color):
	setColor(color)
