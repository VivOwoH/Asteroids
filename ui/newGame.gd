extends Button

export (String, FILE) var next_scene_path = ""

func _on_newGame_button_up():
	Data.reset()
	$onclick.play(0.0)
	get_tree().change_scene(next_scene_path)

func _get_configuration_warning():
	return "next_scene_path must be stated" if next_scene_path == "" else ""

func _on_newGame_mouse_entered():
	$gui.play(0.0)
