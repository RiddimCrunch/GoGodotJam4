extends Control

func _process(delta):
	$Container/Cohesion.set_position(Vector2(350,550))
	$Container/Alignment.set_position(Vector2(450,550))
	$Container/Separation.set_position(Vector2(550,550))
	$Container/Speed.set_position(Vector2(650,550))

func _getCurrentValues() -> Dictionary:
	var values = {}
	for ui in $Container.get_children():
		values[ui.param] = ui._getValue()
	return values
