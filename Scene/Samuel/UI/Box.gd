extends Control

export var param = ""
export var group = "boids"
export var initValue = 0
export var minValue = 0
export var maxValue = 100

onready var boxValue = initValue

func _ready():
	$VerticalContainer/SpinBox.min_value = minValue
	$VerticalContainer/SpinBox.max_value = maxValue
	
	$VerticalContainer/Title.text = param
	_setInitValue()

func _ValueChanged(value):
	boxValue = value
	get_tree().call_group(group, "set"+param, boxValue)
	
func _on_SpinBox_value_changed(value):
	_ValueChanged(value)
	$VerticalContainer/SpinBox.value = value
	
func _setInitValue():
	$VerticalContainer/SpinBox.value = boxValue

func _getValue():
	return boxValue
