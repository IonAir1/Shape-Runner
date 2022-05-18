extends KinematicBody2D

var speed = 500 #player speed
var jump_speed = -1300 #jump speed
var gravity = 4000 #gravity
var friction = 0.1 #running friction
var acceleration = 0.25 #running acceleration
var velocity = Vector2.ZERO #velocity
var swim_jump = false #timer for disabling jumping when game C
var run = preload("res://assets/runner.png")
var fly = preload("res://assets/flyer.png")
var swim = preload("res://assets/swimmer.png")
var touch = 0

func _ready():
	get_node("circle").scale = Vector2.ZERO


func swimwait():#timer for game C, jumping
	yield(get_tree().create_timer(0.5), "timeout")
	swim_jump = false

func _physics_process(delta):
	if Global.state == 0: #player properties for Game A
		jump_speed = -1300
		gravity = 4000
		velocity.y += gravity * delta
		velocity = move_and_slide(velocity, Vector2.UP)
		if Input.is_action_pressed("w") or touch != 0:
			if is_on_floor():
				velocity.y = jump_speed
				get_parent().get_node("sounds/jump").play()
		get_node("sprite").texture = run


	elif Global.state == 1: #player properties for Game B
		if Global.switch_to_b:
			Global.switch_to_b = false
			if is_on_floor():
				velocity.y = -1500
		var dir = 0
		if Input.is_action_pressed("s") or touch == -1:
			dir += 1
		if Input.is_action_pressed("w") or touch == 1:
			dir -= 1
		if dir != 0:
			velocity.y = lerp(velocity.y, dir * speed, acceleration)
		else:
			velocity.y = lerp(velocity.y, 0, friction)
		velocity = move_and_slide(velocity, Vector2.UP)
		get_node("sprite").texture = fly


	elif Global.state == 2: #player properties for game C
		jump_speed = -600
		gravity = 950
		if position.y > 380 and position.y < 420 and not swim_jump:
			position.y = 400
			velocity.y = 0
		elif position.y < 400:
			velocity.y += gravity * delta
		elif position.y > 400:
			velocity.y -= gravity * delta
		elif position.y == 400:
			velocity.y = 0
		if Input.is_action_pressed("w") or touch == 1:
			if position.y == 400 and not swim_jump:
				velocity.y = jump_speed
				swim_jump = true
				swimwait()
				get_parent().get_node("sounds/jump").play()
		if Input.is_action_pressed("s") or touch == -1:
			if position.y == 400 and not swim_jump:
				velocity.y = jump_speed * -1
				swim_jump = true
				swimwait()
				get_parent().get_node("sounds/dive").play()
		velocity = move_and_slide(velocity, Vector2.UP)
		get_node("sprite").texture = swim
	
	
	elif Global.state == 3: #player properties for Game D
		var dir = 0
		if Input.is_action_pressed("s") or touch == -1:
			dir += 1
		if Input.is_action_pressed("w") or touch == 1:
			dir -= 1
		if dir != 0:
			velocity.y = lerp(velocity.y, dir * speed, acceleration)
		else:
			velocity.y = lerp(velocity.y, 0, friction)
		velocity = move_and_slide(velocity, Vector2.UP)
		get_node("sprite").texture = fly


	if Global.new: #transition
		Global.new = false
		pop()

func pop(): #transition animation
	var change = 0.02
	get_node("circle").scale += Vector2(0.1, 0.1)
	yield(get_tree().create_timer(change), "timeout")
	get_node("circle").scale += Vector2(0.1, 0.1)
	yield(get_tree().create_timer(change), "timeout")
	get_node("circle").scale += Vector2(0.1, 0.1)
	yield(get_tree().create_timer(change), "timeout")
	get_node("circle").scale += Vector2(0.1, 0.1)
	yield(get_tree().create_timer(change), "timeout")
	get_node("circle").scale += Vector2(0.1, 0.1)
	yield(get_tree().create_timer(change), "timeout")
	get_node("circle").scale += Vector2(0.1, 0.1)
	yield(get_tree().create_timer(change), "timeout")
	get_node("circle").scale += Vector2(0.1, 0.1)
	yield(get_tree().create_timer(change), "timeout")
	get_node("circle").scale += Vector2(0.1, 0.1)
	yield(get_tree().create_timer(change), "timeout")
	get_node("circle").scale += Vector2(0.1, 0.1)
	yield(get_tree().create_timer(change), "timeout")
	get_node("circle").scale += Vector2(0.1, 0.1)
	yield(get_tree().create_timer(change), "timeout")
	get_node("circle").scale = Vector2.ZERO

