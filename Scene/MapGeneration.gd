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
	$UI.hide()
	$Color.hide()
	$ColorPick.hide()
	$AddBoid.hide()
	$RemoveBoid.hide()

func _process(_delta):
	$ColorPick.set_position(Vector2(750, 550))
	$Color.set_position(Vector2(760, 570))
	$AddBoid.set_position(Vector2(150, 570))
	$RemoveBoid.set_position(Vector2(230, 570))
