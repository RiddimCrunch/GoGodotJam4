extends KinematicBody2D
 
#Top speed
var topSpeed = 5;
#Top steer
var topSteer = 0.05;
#Mass
var mass = 1;
#Theta
var theta = 0;
#Rayon
var r = 5;
#Radius
var radiusSeparation = 6 * r;
var radiusAlignment = 12 * r;
var radiusCohesion = 18 * r;
#Weight
var weightSeparation = 2;
var weightAlignment = 1;
var weightCohesion = 1;
#Steer
var steer = Vector2.ZERO
#Sum
var sumAlignment = Vector2.ZERO
var sumCohesion = Vector2.ZERO
#Vector 0
var zeroVector  = Vector2.ZERO
#Location
var location: Vector2
#Velocity
var velocity: Vector2
#Acceleration
var acceleration: Vector2

#Screen size x and y
var width = OS.get_window_size().x
var height = OS.get_window_size().y


func _ready():
	randomize()
	velocity = Vector2(rand_range(-1, 1), rand_range(-1, 1)).normalized() * topSpeed

func Mover(loc: Vector2, vel: Vector2) -> void:
	location = loc
	velocity = vel
	acceleration = Vector2(0, 0)

func edges():
	if (location.x < 0): 
		location.x = width - r;
	elif (location.x + r> width): 
		location.x = 0;
	
	if (location.y < 0): 
		location.y = height - r;
	elif (location.y + r> height): 
		location.y = 0;
		
func flock(boids: Array) -> void:
	var separation := separate(boids)
	var alignment := align(boids)
	var cohesion := cohesion(boids)
	
	separation *= weightSeparation
	alignment *= weightAlignment
	cohesion *= weightCohesion
	
	applyForce(separation)
	applyForce(alignment)
	applyForce(cohesion)
	
	
func separate(boids: Array) -> Vector2:
	var steer: Vector2 = Vector2.ZERO
	var count: int = 0
	
	for other in boids:
		var d = location.distance_to(other.location)
		if d > 0 and d < radiusSeparation:
			var diff = location - other.location
			diff = diff.normalized() / d
			steer += diff
			count += 1
			
	if count > 0:
		steer /= count
		
	if steer.length() > 0:
		steer = steer.normalized() * topSpeed
		steer -= velocity
		steer = steer.clamped(topSteer)
		
	return steer

func align(boids: Array) -> Vector2:
	var sumAlignment = Vector2.ZERO
	var count = 0
	for other in boids:
		var d = location.distance_to(other.location)
		if d > 0 and d < radiusAlignment:
			sumAlignment += other.velocity
			count += 1
	if count > 0:
		sumAlignment /= count
		sumAlignment = sumAlignment.normalized() * topSpeed
		var steer = sumAlignment - velocity
		steer = steer.clamped(topSteer)
		return steer
	else:
		return Vector2.ZERO

func cohesion(boids: Array) -> Vector2:
	var sumCohesion = Vector2.ZERO
	var count = 0
	for other in boids:
		var d = location.distance_to(other.location)
		if d > 0 and d < radiusCohesion:
			sumCohesion += other.location
			count += 1
	if count > 0:
		sumCohesion /= count
		return seek(sumCohesion)
	else:
		return Vector2.ZERO
		
func applyForce(force: Vector2):
	var f: Vector2
	
	if mass != 1:
		f = force / mass
	else:
		f = force
	
	acceleration += f
	
func seek(target: Vector2) -> Vector2:
	var desired: Vector2 = target - location
	desired = desired.normalized() * topSpeed
	var steer: Vector2 = desired - velocity
	steer = steer.clamped(topSteer)
	return steer

func _process(delta):
	edges()
	velocity += acceleration
	velocity = velocity.normalized() * topSpeed
	theta = velocity.angle() + deg2rad(90)
	location += velocity * delta
	acceleration *= 0
	
#	func colliding(p:Projectile) -> bool:
#		var result = false
#		var distance = distance(location, p.location)
#		if r + p.r >= distance:
#			result = true
#		return result
