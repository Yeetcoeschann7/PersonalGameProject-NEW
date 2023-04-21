extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("default")
	
func _on_body_entered(body):
	if body.is_in_group("player"):
		if get_tree().current_scene.name == "TestLevel":
			get_tree().change_scene_to_file("res://Scenes/Maps/level_1/level_1.tscn")
		else:
			get_tree().change_scene_to_file("res://Scenes/Menus/main_menu.tscn")
