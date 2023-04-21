extends StaticBody2D

@export var locked = true
var done = false
var go = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$door_sprite.play("default")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if go and done == false:
		$door_collider.set_deferred("disabled", true)
		$key_collect/key_collider.set_deferred("disabled", true)
		$door_sprite.play("unlock")
		if $unlock_noise.is_playing() == false:
			$unlock_noise.play()
		done = true

func _on_key_collect_body_entered(body):
	if body.is_in_group("player") and locked == false:
		go = true
