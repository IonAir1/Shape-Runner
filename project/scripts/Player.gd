extends KinematicBody2D

var speed = 500
var jump_speed = -1300
var gravity = 4000
var friction = 0.1
var acceleration = 0.25
var velocity = Vector2.ZERO
var swim_jump = 0
var run = preload("res://assets/runner.png")
var fly = preload("res://assets/flyer.png")
var swim = preload("res://assets/swimmer.png")


func _ready():
	get_node("circle").scale = Vector2.ZERO


func swimwait():
	yield(get_tree().create_timer(0.5), "timeout")
	swim_jump = 0

func _physics_process(delta):

	if Global.state == 0:
		jump_speed = -1300
		gravity = 4000
		velocity.y += gravity * delta
		velocity = move_and_slide(velocity, Vector2.UP)
		if Input.is_action_just_pressed("w"):
			if is_on_floor():
				velocity.y = jump_speed
				get_parent().get_node("sounds/jump").play()
		get_node("sprite").texture = run


	elif Global.state == 1:
		if Global.switch_to_b:
			Global.switch_to_b = false
			if is_on_floor():
				velocity.y = -1500
		var dir = 0
		if Input.is_action_pressed("s"):
			dir += 1
		if Input.is_action_pressed("w"):
			dir -= 1
		if dir != 0:
			velocity.y = lerp(velocity.y, dir * speed, acceleration)
		else:
			velocity.y = lerp(velocity.y, 0, friction)
		velocity = move_and_slide(velocity, Vector2.UP)
		get_node("sprite").texture = fly


	elif Global.state == 2:
		jump_speed = -600
		gravity = 950
		if position.y > 380 and position.y < 420 and swim_jump == 0:
			position.y = 400
			velocity.y = 0
		elif position.y < 400:
			velocity.y += gravity * delta
		elif position.y > 400:
			velocity.y -= gravity * delta
		elif position.y == 400:
			velocity.y = 0
		if Input.is_action_pressed("w"):
			if position.y == 400 and swim_jump == 0:
				velocity.y = jump_speed
				swim_jump = 1
				swimwait()
				get_parent().get_node("sounds/jump").play()
		if Input.is_action_pressed("s"):
			if position.y == 400 and swim_jump == 0:
				velocity.y = jump_speed * -1
				swim_jump = 1
				swimwait()
				get_parent().get_node("sounds/dive").play()
		velocity = move_and_slide(velocity, Vector2.UP)
		get_node("sprite").texture = swim
	
	
	elif Global.state == 3:
		var dir = 0
		if Input.is_action_pressed("s"):
			dir += 1
		if Input.is_action_pressed("w"):
			dir -= 1
		if dir != 0:
			velocity.y = lerp(velocity.y, dir * speed, acceleration)
		else:
			velocity.y = lerp(velocity.y, 0, friction)
		velocity = move_and_slide(velocity, Vector2.UP)
		get_node("sprite").texture = fly


	if Global.new:
		Global.new = false
		pop()

func pop():
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
	print("A")
