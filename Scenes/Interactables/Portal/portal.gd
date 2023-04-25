extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("default")
	$upIcon.visible = false
	

func _process(delta):
	if self.overlaps_body(get_tree().get_first_node_in_group("player")):
		$upIcon.visible = true
		if Input.is_action_pressed("up"):
			if get_tree().current_scene.name == "TestLevel":
				get_tree().change_scene_to_file("res://Scenes/Maps/level_1/level_1.tscn")
			else:
				get_tree().change_scene_to_file("res://Scenes/Menus/main_menu.tscn")
	else:
		$upIcon.visible = false
