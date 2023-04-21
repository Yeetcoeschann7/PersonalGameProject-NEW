extends Control

func _on_no_button_pressed():
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	get_tree().change_scene_to_file("res://Scenes/Menus/main_menu.tscn");

func _on_yes_button_pressed():
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	get_tree().change_scene_to_file("res://Scenes/Menus/main_menu.tscn");
