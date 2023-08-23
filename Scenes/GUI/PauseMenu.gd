extends Control

var is_paused = false : set = set_is_paused

func _process(_delta):
	if is_paused == false:
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		self.is_paused = !is_paused
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func set_is_paused(value):
	is_paused = value
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().paused = is_paused
	visible = is_paused
	if visible == true:
		$CenterContainer/VBoxContainer/ResumeButton.grab_focus()
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


func _on_resume_button_pressed():
	self.is_paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


func _on_quit_button_pressed():
	self.is_paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().change_scene_to_file("res://Scenes/Menus/main_menu.tscn");
