extends KinematicBody2D

export var speed = Vector2(150,150)
export var score = 200
var _direction = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var viewport = get_viewport().size
	self.position.x = rng.randf_range(0,viewport.x)
	self.position.y = rng.randf_range(0,viewport.y) 
	_direction.x = rng.randf_range(-1.0,1.0)
	_direction.y = rng.randf_range(-1.0,1.0)

func get_velocity() -> Vector2:
	var out_velocity = Vector2.ZERO
	out_velocity.x += speed.x * _direction.x
	out_velocity.y += speed.y * _direction.y
	return out_velocity

func _physics_process(delta):
	move_and_slide(get_velocity())

