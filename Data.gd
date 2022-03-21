extends Node

signal score_updated
signal fuel_updated

var score = 0 setget set_score
# default start with 200 units of fuel
var fuel = 200 setget set_fuel
var bestscore = 0 setget set_bestscore
const filepath = "user://bestscore.data"

func _ready():
	load_bestscore()

func set_score(value):
	score = value
	emit_signal("score_updated")

func set_fuel(value):
	fuel = value
	emit_signal("fuel_updated")

func set_bestscore(value):
	bestscore = value
	save_bestscore()

func reset():
	score = 0
	fuel = 200

func save_bestscore():
	var file = File.new()
	file.open(filepath, File.WRITE)
	file.store_var(bestscore)
	file.close()
	
func load_bestscore():
	var file = File.new()
	if not file.file_exists(filepath):
		return
	file.open(filepath, File.READ)
	bestscore = file.get_var()
	file.close()
	
	
