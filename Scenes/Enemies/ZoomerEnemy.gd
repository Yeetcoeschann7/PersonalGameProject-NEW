extends CharacterBody2D


var move = Vector2(0,0)
var rotating: int
var halfRadius = 15 #$CollisionShape2D.shape.radius
var isDying = false
var isHit = false
var HP = 3
	
func _process(_delta):
	$AnimatedSprite2D.animation = "default"
	$AnimatedSprite2D.play()

func _physics_process(delta):
	if not isDying and not isHit:
		if rotating:
			rotation = lerp_angle(rotation, move.angle(), 0.1)
			rotating -= 1
			return 
		
		var col := move_and_collide(move * -50 * delta)
		if col and col.get_normal().rotated(PI/2).dot(move) < 0.5:
			rotating = 4
			move = col.get_normal().rotated(PI/2)
			return
		
		var pos := position
		col = move_and_collide(move.rotated(PI/2) * halfRadius)
		if not col:
			for i in 10:
				position = pos
				rotate(PI/32)
				move = move.rotated(PI/32)
				col = move_and_collide(move.rotated(PI/2) * halfRadius)
				
				if col:
					move = col.get_normal().rotated(PI/2)
					rotation = move.angle()
					break
		else:
			move = col.get_normal().rotated(PI/2)
			rotation = move.angle()


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
				isHit = false
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
	isHit = false
	$AnimatedSprite2D.modulate = Color(1, 1, 1)
	get_node("Area2D/CollisionShape2D").set_deferred("disabled", false)
