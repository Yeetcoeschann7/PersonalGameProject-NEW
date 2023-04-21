extends CharacterBody2D

const SPEED: int = 200;
const JUMPFORCE: int = 400;
const GRAVITY: int = 800;
var nextLand: bool = false;
var spawn = self.position;
var isDying = false
var bullet_scene = preload("res://Scenes/Player/bulletRight.tscn")
@onready
var fire_pt = get_node("AnimatedSprite/shootRight")
var sound_done = false

func _physics_process(delta):
	velocity.x = 0;
	# Inputs for movement.
	if not isDying:
		$AnimatedSprite/GunSprite.visible = true
		if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
			if Input.is_action_pressed("move_left"):
				get_node("AnimatedSprite").set_flip_h(true) # Flips sprite to the left
				get_node("AnimatedSprite/GunSprite").set_flip_h(true) # Flips sprite to the left
				fire_pt = get_node("AnimatedSprite/shootLeft")
				bullet_scene = preload("res://Scenes/Player/bulletLeft.tscn")
				if is_on_floor():
					$AnimatedSprite.animation =  "walking"
				else:
					if velocity.y < 0:
						$AnimatedSprite.animation =  "jump"
					else:
						$AnimatedSprite.animation =  "fall"
						nextLand = true
				velocity.x -= SPEED;
			if Input.is_action_pressed("move_right"):
				get_node("AnimatedSprite").set_flip_h(false) # Flips sprite to the right
				get_node("AnimatedSprite/GunSprite").set_flip_h(false) # Flips sprite to the left
				fire_pt = get_node("AnimatedSprite/shootRight")
				bullet_scene = preload("res://Scenes/Player/bulletRight.tscn")
				if is_on_floor():
					$AnimatedSprite.animation =  "walking"
				else:
					if velocity.y < 0:
						$AnimatedSprite.animation =  "jump"
					else:
						$AnimatedSprite.animation =  "fall"
						nextLand = true
				velocity.x += SPEED;
		else:
			if is_on_floor():
				$AnimatedSprite.animation =  "default"
			elif velocity.y < 0:
				$AnimatedSprite.animation =  "jump"
			else:
				$AnimatedSprite.animation =  "fall"
				nextLand = true
		if Input.is_action_just_pressed("jump") and is_on_floor():
			if !$jump_sound.is_playing():
				$jump_sound.play()
			velocity.y -= JUMPFORCE
		if Input.is_action_just_released("jump"):
			if velocity.y < -100:
				velocity.y = -100
	else:
		$AnimatedSprite/GunSprite.visible = false

	velocity.y += GRAVITY * delta;
	move_and_slide();
	
func respawn(_body):
	if sound_done == false:
		$damage_sound.play()
		sound_done = true
	isDying = true
	$AnimatedSprite.animation =  "death"
	$DeathTimer.start()
	
func _on_death_timer_timeout():
	self.global_position = spawn;
	$AnimatedSprite.animation =  "revive"
	$ReviveTimer.start()

func _on_revive_timer_timeout():
	isDying = false
	sound_done = false

func _process(_delta):
	if not isDying:
		if Input.is_action_just_pressed("fire"):
			var bullet_inst = bullet_scene.instantiate()
			$shoot_sound.play()
			bullet_inst.position = fire_pt.global_position
			get_tree().root.add_child(bullet_inst)
