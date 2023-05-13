extends Control

onready var title = $Title
onready var setting = $SettingsMenu
onready var startBtn = $Container/StartBtn
onready var container = $Container
onready var background = $Background

func _ready():
	startBtn.grab_focus()

func _process(_delta):
	title.set_text("The end justifies the meat")
	title.set_position(Vector2(OS.window_size.x/2 - 175, 100))
	title.set_scale(Vector2(2,2))
	container.set_position(Vector2(OS.window_size.x/2 - 125, OS.window_size.y/2 - 50))
	container.set_scale(Vector2(4,4))
	background.set_size(Vector2(OS.window_size.x, OS.window_size.y))



func _on_StartBtn_pressed():
	return get_tree().change_scene("res://Scene/WorldA.tscn")


func _on_SettingsBtn_pressed():
	setting.popup_centered()
	setting.set_size(Vector2(OS.window_size.x, OS.window_size.y))
	setting.set_position(Vector2(0,0))


func _on_QuitBtn_pressed():
	get_tree().quit()

func hideSetting():
	pass
