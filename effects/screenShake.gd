extends Node

onready var camera = get_parent()

var amplitude = 0
var priority = 0

func start(
		duration = 0.1,
		frequency = 10,
		amplitude = 5,
		priority = 0):
	if priority >= self.priority:
		self.priority = priority
		self.amplitude = amplitude
		
		$frequency.wait_time = 1/float(frequency)		# casting frequency to seconds f=1/t
		$duration.wait_time = duration
		$frequency.start()
		$duration.start()
	
		_new_shake()

#############################################

func _new_shake():
	var rand = Vector2()
	rand.x = rand_range(-amplitude, amplitude)
	rand.y = rand_range(-amplitude, amplitude)
	
	$Tween.interpolate_property(camera, "offset", camera.offset, rand, \
		$frequency.wait_time, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	$Tween.start()

func _reset():
	$Tween.interpolate_property(camera, "offset", camera.offset, Vector2(), \
		$frequency.wait_time, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	$Tween.start()
	
	priority = 0

func _on_frequency_timeout():
	_new_shake()
	
func _on_duration_timeout():
	_reset()
	$frequency.stop()
