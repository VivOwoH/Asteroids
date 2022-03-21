extends Control

onready var new_bestscore = $newBestScore
onready var score = $Score

func _process(delta):
	if visible:
		update()
		set_process(false)

func update():
	if Data.score > Data.bestscore:
		Data.bestscore = Data.score
		score.visible = false
		new_bestscore.text = "New highscore: %s" % Data.bestscore
	else:
		new_bestscore.visible = false
		score.text = "Score: %s" % Data.score
