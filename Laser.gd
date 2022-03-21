extends RayCast2D

const explosions = preload("res://effects/Explosion.tscn")

onready var asteroids = get_node("/root/Main/Asteroids")
onready var camera_shake = get_node("/root/Main/camera/screenShake")
var is_casting = false setget set_is_casting

func _ready():
	set_physics_process(false)
	$Line2D.points[1] = Vector2.ZERO

func _physics_process(delta):
	var cast_point = cast_to
	force_raycast_update()
	
	$collisionParticle.emitting = is_colliding()
	
	if is_colliding():
		var collider = get_collider()
		if collider.get_parent().get_parent() == asteroids:
			asteroids.get_node("explosion").play()
			asteroids.get_node("Explosion").position = collider.position
			asteroids.get_node("Explosion").exploding()
			
			camera_shake.start()
			Data.score += collider.score
			collider.queue_free()
			
		cast_point = to_local(get_collision_point())
		$collisionParticle.global_rotation = get_collision_normal().angle()
		$collisionParticle.position = cast_point
	
	# the end point of the 2 points in line2D is cast_point
	$Line2D.points[1] = cast_point
	
	$beamParticle.position = cast_point * 0.5
	$beamParticle.process_material.emission_box_extents.x = cast_point.length()*0.5

func set_is_casting(cast: bool):
	is_casting = cast
	$CastingParticle.emitting = is_casting
	$beamParticle.emitting = is_casting
	
	if is_casting:
		appear()
	else:
		$collisionParticle.emitting = false
		disappear()
	set_physics_process(is_casting)

func appear():
	$Tween.stop_all()
	$Tween.interpolate_property($Line2D, "width", 0, 5.0, 0.1)
	$Tween.start()

func disappear():
	$Tween.stop_all()
	$Tween.interpolate_property($Line2D, "width", 5.0, 0, 0.1)
	$Tween.start()
