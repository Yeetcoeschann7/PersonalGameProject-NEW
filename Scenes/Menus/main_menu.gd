extends Control

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Maps/level_1/level_1.tscn");
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


func _on_quit_button_pressed():
	get_tree().quit()

