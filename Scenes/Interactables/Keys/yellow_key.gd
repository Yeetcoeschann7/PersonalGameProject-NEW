extends Area2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _ready():
	$AnimationPlayer.play("float")

func _on_body_entered(body):
	if body.is_in_group("player"):
		print("GOT KEY!")
		$key_sprite.visible = false
		$key_dissolve.emitting = true
		$collect_noise.play()
		$Timer.start()
		$key_collider.set_deferred("disabled", true)
		var door = get_tree().get_first_node_in_group("door")
		door.locked = false

func _on_timer_timeout():
	queue_free()
