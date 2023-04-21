extends CharacterBody2D


var SPEED = 50.0
const JUMP_VELOCITY = -400.0
var HP = 5
var isDying = false
var isHit = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	get_node("AnimatedSprite2D").set_flip_h(true)

func _physics_process(delta):
	if not isDying and not isHit:
		# Add the gravity.
		if not is_on_floor():
			velocity.y += gravity * delta
		detect_turn_around()
		velocity.x = -SPEED
		move_and_slide()

func detect_turn_around():
	if (not $RayCastLeft.is_colliding() and is_on_floor()) or (not $RayCastRight.is_colliding() and is_on_floor()) or $RayCastLeftWall.is_colliding() or $RayCastRightWall.is_colliding():
		if SPEED == 50:
			get_node("AnimatedSprite2D").set_flip_h(false)
			SPEED = -50
		else:
			get_node("AnimatedSprite2D").set_flip_h(true)
			SPEED = 50

func EnemyHurt(area):
	print("hit", area)
	if not isDying:
		if area.is_in_group("bullet"):
			HP -= 1
			if HP <= 0:
				isDying = true
				get_node("AnimatedSprite2D").visible = false
				get_node("CollisionShape2D").set_deferred("disabled", true)
				get_node("Area2D/GPUParticles2D").emitting = true
				get_node("Area2D/Timer").start()
				if !$die_sound.is_playing():
					$die_sound.play()
			else:
				get_node("Area2D/HitTimer").start()
				$damage_sound.play()
			isHit = true
			$AnimatedSprite2D.modulate = Color(1, 0, 0)
			get_node("Area2D/CollisionShape2D").set_deferred("disabled", true)
			
func _on_timer_timeout():
	get_node("Area2D/GPUParticles2D").emitting = false
	queue_free()
	isHit = false
	$AnimatedSprite2D.modulate = Color(1, 1, 1)

func _on_hit_timer_timeout():
	isHit = false
	$AnimatedSprite2D.modulate = Color(1, 1, 1)
	get_node("Area2D/CollisionShape2D").set_deferred("disabled", false)
