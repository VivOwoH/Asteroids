extends KinematicBody2D


############ LOAD CONST ########################

const bullets = preload("res://agents/Bullet.tscn")
const ACTION = ["Go_right", "Go_down", "Go_left", "Go_up"]

###############################################

onready var laser = $Laser
onready var camera_shake = get_node("/root/Main/camera/screenShake")

export var max_speed = Vector2(10,10)
export var impulse = 3.0
export var bullet_fuel_consumption = 1
export var spaceship_fuel_consumption = 1
export var laser_fuel_consumption = 1
var _velocity = Vector2(0,-0.01)

###############################################

func get_direction() -> Vector2:
	# direction = Vector2(x,y)
	var direction = Vector2(
		Input.get_action_strength("Go_right") - Input.get_action_strength("Go_left"),
		Input.get_action_strength("Go_down") - Input.get_action_strength("Go_up")
	)
	return direction
	
func get_velocity(
		current_velocity: Vector2,
		direction: Vector2) -> Vector2:
	var out_velocity = current_velocity
	out_velocity.x += impulse * get_physics_process_delta_time() * direction.x
	out_velocity.y += impulse * get_physics_process_delta_time() * direction.y
	return out_velocity

func fire():
	var new_bullet = bullets.instance()
	$Bullets.add_child(new_bullet)
	Data.fuel -= bullet_fuel_consumption

###############################################

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	_velocity = get_velocity(_velocity, get_direction()) 
	$spaceship.rotation = _velocity.angle()

	var collision = move_and_collide(_velocity)
	if collision:
		$Explosion.exploding()
			
		camera_shake.start(0.1,20,20,0)
		$collisionSound.play()
		collision.collider.queue_free()
		Data.score -= 100

	### fire bullets
	if Input.is_action_pressed("fire") and \
			$Bullets.get_child_count() == 0 and \
			Data.fuel > 0:
		fire()
		$fireSound.play()
		
	### fire laser
	laser.rotation = $spaceship.rotation
	if Input.is_action_just_pressed("laser"):
		laser.is_casting = true
	if Input.is_action_just_released("laser"):
		$Laser/laserSound.stop()
		laser.is_casting = false
	if laser.is_casting:
		if not $Laser/laserSound.playing and Data.fuel > 0:
			$Laser/laserSound.play()
		Data.fuel -= laser_fuel_consumption
	
	for action in ACTION:
		if Input.is_action_just_pressed(action):
			Data.fuel -= spaceship_fuel_consumption
		if Input.is_action_pressed(action) and \
				not $thrustSound.playing and \
				Data.fuel > 0:
			$thrustSound.play()
	
	



	

	
		
