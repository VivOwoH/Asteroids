extends Button

func _on_quit_button_up():
	$onclick.play(0.0)
	get_tree().quit()


func _on_quit_mouse_entered():
	$gui.play(0.0)
