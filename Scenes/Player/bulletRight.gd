extends Area2D

var speed: float = 400

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x += speed * delta

func _on_area_entered(_area):
	queue_free()
	
func _on_body_entered(_body):
	queue_free()

func _on_notifier_screen_exited():
	queue_free()
