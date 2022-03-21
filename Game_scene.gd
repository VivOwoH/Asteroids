extends Node2D

############ LOAD NODES ########################

const small_asteroid = preload("res://asteroids/small_asteroid.tscn")
const large_asteroid = preload("res://asteroids/large_asteroid.tscn")

################################################

export var max_asteroids_count = 10
var playtime = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $Asteroids/large.get_child_count() < max_asteroids_count/2:
		$Asteroids/large.add_child(large_asteroid.instance())
	if $Asteroids/small.get_child_count() < max_asteroids_count/2:
		$Asteroids/small.add_child(small_asteroid.instance())
	
	if Data.fuel <= 0:
		$".".visible = false
		for child in $Asteroids/large.get_children():
			child.queue_free()
		for child in $Asteroids/small.get_children():
			child.queue_free()
		$UI/UserInterface.visible = false
		$CanvasLayer/TextureRect.visible = true
		
		if not $UI/gameOver/gameOverSound.playing and playtime <1:
			$UI/gameOver/gameOverSound.play()
			playtime += 1
		
		$UI/gameOver.visible = true
		

func _unhandled_input(event):
	if event.is_action_released("retry"):
		get_tree().reload_current_scene()
