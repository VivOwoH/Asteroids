extends Control

############ LOAD NODES ########################

const small_asteroid = preload("res://asteroids/small_asteroid.tscn")
const large_asteroid = preload("res://asteroids/large_asteroid.tscn")

################################################

export var max_asteroids_count = 10

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $Asteroids/large.get_child_count() < max_asteroids_count/2:
		$Asteroids/large.add_child(large_asteroid.instance())
	if $Asteroids/small.get_child_count() < max_asteroids_count/2:
		$Asteroids/small.add_child(small_asteroid.instance())
