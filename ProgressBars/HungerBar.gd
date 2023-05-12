extends Control

onready var progress = $TextureProgress

func _ready():
	pass
	
func set_value(value):
	progress.value = value
