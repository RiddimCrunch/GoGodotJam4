extends Node

var cells: Array
var scale: int
var size: Vector2
var scaledPoint
var x 
var y
var bodies
var up
var down
var left
var right

func _init(unscaledSize: Vector2, newScale: int):
	scale = newScale
	size = Vector2(_scaleAxis(unscaledSize.x), _scaleAxis(unscaledSize.y))
	cells = range(size.x + 1)

	for x in range(cells.size()):
		cells[x] = range(size.y + 1)

		for y in cells[x].size():
			cells[x][y] = []


func _scaleAxis(point: float) -> int:
	return int(floor(point / scale))


func _scalePoint(vector: Vector2) -> Vector2:
	scaledPoint = (vector / scale).floor()
	scaledPoint.x = min(max(scaledPoint.x, 0), size.x)
	scaledPoint.y = min(max(scaledPoint.y, 0), size.y)
	return scaledPoint


func _addBody(body: Node2D, scaledPoint: Vector2) -> void:
	cells[scaledPoint.x][scaledPoint.y].append(body)


func _getBodies(scaledPoint: Vector2):
	x = min(max(scaledPoint.x, 0), size.x)
	y = min(max(scaledPoint.y, 0), size.y)
	bodies = [cells[x][y]]
	up = y - 1
	down = y + 1
	left = x - 1
	right = x + 1
	
	if up > 0:
		bodies.append(cells[x][up])
		if left > 0:
			bodies.append(cells[left][up])
		if right <= size.x:
			bodies.append(cells[right][up])

	if down <= size.y:
		bodies.append(cells[x][down])
		if left > 0:
			bodies.append(cells[left][down])
		if right <= size.x:
			bodies.append(cells[right][down])

	if left > 0:
		bodies.append(cells[left][y])

	if right <= size.x:
		bodies.append(cells[right][y])

	return bodies
