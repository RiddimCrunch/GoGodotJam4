extends Node2D

export(PackedScene) var Enemy;

onready var scene_root = get_node("/root/SamuelCossette/BoidGroup")

var enemy
var ennemis = []
var random_number_x = rand_range(0, OS.get_window_size().x)
var random_number_y = rand_range(0,  OS.get_window_size().y)

func spawn_enemy(position):
	#instanciate the ennemy
	enemy = Enemy.instance()
	#Give this enemy a random position 
	enemy.position = position
	#Add the enemy to the scene
	scene_root.add_child(enemy)
	#Add the enemy to the collection
	ennemis.append(enemy)


func _process(delta):
	#Give random number between 0 and 1024 for the x axis
	random_number_x = rand_range(0, OS.get_window_size().x)
	#Give random number between 0 and 600 for the y axis
	random_number_y = rand_range(0, OS.get_window_size().y)


#When this function is callout, a enemy appear on the screen
func _on_Timer_timeout():
	spawn_enemy(Vector2(random_number_x, random_number_y))
