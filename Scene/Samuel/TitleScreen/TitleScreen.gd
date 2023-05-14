extends Control

onready var title = $Title
onready var startBtn = $Container/StartBtn
onready var container = $Container

func _ready():
	startBtn.grab_focus()

func _process(_delta):
	title.set_text("Boid simulator")
	title.set_position(Vector2(OS.window_size.x/2 - 130, 100))
	title.set_scale(Vector2(2,2))
	container.set_position(Vector2(OS.window_size.x/2 - 125, OS.window_size.y/2 - 50))
	container.set_scale(Vector2(4,4))



func _on_StartBtn_pressed():
	container.hide()
	title.hide()
	$"../UI".show()

func _on_QuitBtn_pressed():
	get_tree().quit()
