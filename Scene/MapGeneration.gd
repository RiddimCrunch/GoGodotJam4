extends Node2D

var width = OS.get_window_size().x
var height = OS.get_window_size().y

#Noise generator based on Open Simplex.
var openSimplexNoise = OpenSimplexNoise.new()

func generate_map(period, octave):
	#Seed used to generate random values, different seeds will generate different noise maps
	openSimplexNoise.seed = randi()
	#Period of the base octave
	openSimplexNoise.period = period
	#Number of OpenSimplex noise layers that are sampled to get the fractal noise
	openSimplexNoise.octaves = octave

const NUM_BOIDS = 10
var boids = []

export(PackedScene) var Boid

func _ready():
	for i in range(NUM_BOIDS):
		var boid = Boid.instance()
		boid.Mover(Vector2(rand_range(0, 500), rand_range(0, 500)), Vector2(rand_range(-5, 5), rand_range(-5, 5)))
		boids.append(boid)
		add_child(boid)

func _process(delta):
	for boid in boids:
		boid.flock(boids)
