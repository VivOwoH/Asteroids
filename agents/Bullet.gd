extends KinematicBody2D

onready var spaceship = get_node("/root/Main/Spaceship")
onready var ship_sprite = get_node("/root/Main/Spaceship/spaceship")
onready var asteroids = get_node("/root/Main/Asteroids")
onready var camera_shake = get_node("/root/Main/camera/screenShake")

export var speed = Vector2(30,30)
export var bullet_survival_time = 0.3

var _direction = Vector2.ZERO

func _ready():
	var _angle = ship_sprite.rotation
	_direction = Vector2(cos(_angle), sin(_angle))
	self.position = spaceship.position
	
	# Add a timer to this node
	var timer = Timer.new()
	add_child(timer)
	# Connect the timer to make it call "queue_free" after two seconds
	timer.connect("timeout", self, "queue_free")
	timer.set_wait_time(bullet_survival_time)
	timer.start()
	
func get_velocity() -> Vector2:
	var out_velocity = Vector2.ZERO
	out_velocity.x += speed.x * _direction.x
	out_velocity.y += speed.y * _direction.y
	return out_velocity

func _physics_process(delta):
	move_and_slide(get_velocity())
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision and collision.collider.get_parent().get_parent() == asteroids:
			asteroids.get_node("explosion").play()
			asteroids.get_node("Explosion").position = collision.collider.position
			asteroids.get_node("Explosion").exploding()
			
			camera_shake.start()
			Data.score += collision.collider.score
			collision.collider.queue_free()
