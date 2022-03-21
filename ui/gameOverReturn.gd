extends Button
	
export (String, FILE) var next_scene_path = ""

func _on_return_button_up():
	Data.reset()
	get_tree().reload_current_scene()
	change_scene()

func change_scene():
	get_tree().change_scene(next_scene_path)

func _get_configuration_warning():
	return "next_scene_path must be stated" if next_scene_path == "" else ""
