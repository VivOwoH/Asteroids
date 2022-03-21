extends Button

func _on_retry_button_up():
	Data.reset()
	$onclick.play(0.0)
	get_tree().reload_current_scene()


func _on_retry_mouse_entered():
	$gui.play(0.0)
