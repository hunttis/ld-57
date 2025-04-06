extends CenterContainer


func _unhandled_input(event):
	if event.is_action_pressed("ui_accept") and visible:
		get_viewport().set_input_as_handled()
		Global.game_restart.emit()

