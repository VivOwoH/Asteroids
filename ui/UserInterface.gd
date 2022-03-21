extends Control

onready var scene_tree = get_tree()
onready var pause_overlay = $PauseOverlay
onready var score = $Score
onready var bestscore = $Highscore
onready var fuel = $Fuel
onready var anim_player = $PauseOverlay/title/AnimationPlayer

var paused = false setget set_paused

func _ready():
	# everytime score updated, update the score on UI
	Data.connect("score_updated", self, "update_interface")
	Data.connect("fuel_updated", self, "update_interface")
	update_interface()
	
	anim_player.play("blinking")

func update_interface():
	score.text = "Score: %s" % Data.score
	bestscore.text = "Highscore: %s" % Data.bestscore
	fuel.text = "Fuel: %s" % Data.fuel


func set_paused(value):
	paused = value
	scene_tree.paused = value
	pause_overlay.visible = value

func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		# "self" ensure setter function is called
		self.paused = not paused
		scene_tree.set_input_as_handled()





	

	
