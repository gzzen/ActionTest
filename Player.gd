extends Area2D

signal hit
export var speed = 300
var in_action = false
var in_flip = false
var in_fight = false
var direction = true



func _ready():
	$AnimatedSprite.play()
	$AttackArea/FightCollision.disabled = true
	
func _process(delta):
	var velocity = 0
	if Input.is_action_pressed("ui_right") && !in_action:
		velocity += 1
		direction = true
	if Input.is_action_pressed("ui_left") && !in_action:
		velocity -= 1
		direction = false
	if Input.is_key_pressed(KEY_D):
		flip()
	if Input.is_key_pressed(KEY_X):
		fight_1()
	if Input.is_key_pressed(KEY_C):
		fight_2()
	if in_flip:
		if Input.is_action_pressed("ui_left"):
			velocity -= 0.75
			direction = false
		if Input.is_action_pressed("ui_right"):
			velocity += 0.75
			direction = true
	if in_fight:
		if Input.is_action_pressed("ui_left"):
			velocity -= 0.25
			direction = false
		if Input.is_action_pressed("ui_right"):
			velocity += 0.25
			direction = true
	if velocity != 0 && !in_action:
		$AnimatedSprite.animation = "run"
	if velocity == 0 && !in_action:
		$AnimatedSprite.animation = "stand"
	$AnimatedSprite.flip_h = !direction
	velocity = velocity * speed
	change_pos(velocity, delta)
	
func flip(): 
	in_flip = true
	in_action = true
	$AnimatedSprite.animation = "flip"
	$FlipTimer.start()
	
func fight_1():
	if !in_fight:
		in_action = true
		in_fight = true
		$AttackArea/FightCollision.disabled = false
		$FightTimer.start()
		$AnimatedSprite.animation = "fight_1"
	
func fight_2():
	if !in_fight:
		in_action = true
		in_fight = true
		$AttackArea/FightCollision.disabled = false
		$FightTimer.start()
		$AnimatedSprite.animation = "fight_2"
	



func _on_AnimatedSprite_animation_finished():
	in_action = false


func _on_FlipTimer_timeout():
	in_flip = false

func change_pos(velocity, delta):
	position.x += velocity * delta
	position.x = clamp(position.x, 0, get_viewport_rect().size.x)
	


func _on_FightTimer_timeout():
	in_fight = false
	$AttackArea/FightCollision.disabled = true



func _on_AttackArea_body_entered(body):
	emit_signal("hit")
	print("hit")
