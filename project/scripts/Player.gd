extends KinematicBody2D

var vertical_speed = 800 #vertical player speed
var jump_speed = -1300 #jump speed
var gravity = 4000 #gravity
var friction = 0.2 #running friction
var acceleration = 0.25 #running acceleration
var velocity = Vector2.ZERO #velocity
var swim_jump = false #timer for disabling jumping when game C
var run = preload("res://assets/runner.png")
var fly = preload("res://assets/flyer.png")
var swim = preload("res://assets/swimmer.png")
var touch = 0 #touch control
var gravitydir = -1 #gravity; 1 up and -1 down

func _ready():
	get_node("circle").scale = Vector2.ZERO


func swimwait():#timer for game C, jumping
	yield(get_tree().create_timer(0.5, false), "timeout")
	swim_jump = false

func _physics_process(delta):
	
	if Global.graphics: #fancy graphics
		if Global.state == 2:
			$sprite.self_modulate = Color(1.5, 3, 2.4, 1)
			modulate = Color(1, 1, 1, 1)
		else:
			$sprite.self_modulate = Color(1, 1, 1, 1)
			modulate = Color(1.2, 1.2, 1.2, 1)
	
	if $sprite.texture == run: #set collision shape
		$square.set_deferred("disabled", false)
		$Area2D/square.set_deferred("disabled", false)
		$triangle.set_deferred("disabled", true)
		$Area2D/triangle.set_deferred("disabled", true)
		$circle_.set_deferred("disabled", true)
		$Area2D/circle.set_deferred("disabled", true)
	if $sprite.texture == fly:
		$square.set_deferred("disabled", true)
		$Area2D/square.set_deferred("disabled", true)
		$triangle.set_deferred("disabled", false)
		$Area2D/triangle.set_deferred("disabled", false)
		$circle_.set_deferred("disabled", true)
		$Area2D/circle.set_deferred("disabled", true)
	if $sprite.texture == swim:
		$square.set_deferred("disabled", true)
		$Area2D/square.set_deferred("disabled", true)
		$triangle.set_deferred("disabled", true)
		$Area2D/triangle.set_deferred("disabled", true)
		$circle_.set_deferred("disabled", false)
		$Area2D/circle.set_deferred("disabled", false)
	
	
	var ceiling_height = get_parent().get_node("ground/ceiling/ceiling_pos").global_position.y + 25 #ceiling
	if global_position.y <= ceiling_height:
		global_position.y = ceiling_height

	if Global.state == 0: #player properties for Game A
		jump_speed = -1300
		gravity = 4000
		velocity.y += gravity * delta
		velocity = move_and_slide(velocity, Vector2.UP)
		if Input.is_action_pressed("w") or touch != 0:
			if is_on_floor():
				velocity.y = jump_speed
				Audio.get_node("jump").play()
		get_node("sprite").texture = run
		if Global.graphics:
			if is_on_floor():
				$Running.emitting = true
			else:
				$Running.emitting = false
			$Flying.emitting = false
			$Swimming.emitting = false
			$Running_reversed.emitting = false


	elif Global.state == 1 or Global.state == 3 or Global.state == 6: #player properties for Game B,D.G
		if Global.switch_to_b or Global.switch_to_g:
			Global.switch_to_g = false
			Global.switch_to_b = false
			if is_on_floor():
				velocity.y = -1800
			elif is_on_ceiling():
				velocity.y = 1800
		var dir = 0
		if Input.is_action_pressed("s") or touch == -1:
			dir += 1
		if (Input.is_action_pressed("w") or touch == 1) and global_position.y > ceiling_height:
			dir -= 1
		if dir != 0:
			velocity.y = lerp(velocity.y, dir * vertical_speed, acceleration)
		else:
			velocity.y = lerp(velocity.y, 0, friction)
		velocity = move_and_slide(velocity, Vector2.UP)
		get_node("sprite").texture = fly
		if Global.graphics:
			$Running.emitting = false
			$Flying.emitting = true
			$Swimming.emitting = false
			$Running_reversed.emitting = false


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
				Audio.get_node("jump").play()
		if Input.is_action_pressed("s") or touch == -1:
			if position.y == 400 and not swim_jump:
				velocity.y = jump_speed * -1
				swim_jump = true
				swimwait()
				Audio.get_node("dive").play()
		velocity = move_and_slide(velocity, Vector2.UP)
		get_node("sprite").texture = swim
		if Global.graphics:
			$Running.emitting = false
			$Flying.emitting = false
			$Swimming.emitting = true
			$Running_reversed.emitting = false


	if Global.state == 4: #player properties for Game E
		jump_speed = -1800
		gravity = 3000
		velocity.y += gravity * delta
		velocity = move_and_slide(velocity, Vector2.UP)
		if Input.is_action_pressed("w") or touch != 0:
			if is_on_floor():
				velocity.y = jump_speed
				if Global.sounds:
					Audio.get_node("jump").play()
		get_node("sprite").texture = run
		if Global.graphics:
			if is_on_floor():
				$Running.emitting = true
			else:
				$Running.emitting = false
			$Flying.emitting = false
			$Swimming.emitting = false
			$Running_reversed.emitting = false


	if Global.state == 5: #player properties for Game F
		if position.y < 360:
			gravitydir = 1
		else:
			gravitydir = -1
		jump_speed = 4500 * (gravitydir)
		gravity = 10000 * (gravitydir*-1)
		velocity.y += gravity * delta
		velocity = move_and_slide(velocity, Vector2.UP)
		if Input.is_action_just_pressed("w") or Input.is_action_just_pressed("s") or touch != 0:
			touch = 0
			if is_on_floor() or is_on_ceiling():
				velocity.y = jump_speed
				if Global.sounds:
					Audio.get_node("jump").play()
		get_node("sprite").texture = run
		if Global.graphics:
			if is_on_floor():
				$Running.emitting = true
			else:
				$Running.emitting = false
			if is_on_ceiling():
				$Running_reversed.emitting = true
			else:
				$Running_reversed.emitting = false
			$Flying.emitting = false
			$Swimming.emitting = false


	if Global.new: #transition
		Global.new = false
		pop()

func pop(): #transition animation
	var change = 0.02
	get_node("circle").scale += Vector2(0.1, 0.1)
	yield(get_tree().create_timer(change, false), "timeout")
	get_node("circle").scale += Vector2(0.1, 0.1)
	yield(get_tree().create_timer(change, false), "timeout")
	get_node("circle").scale += Vector2(0.1, 0.1)
	yield(get_tree().create_timer(change, false), "timeout")
	get_node("circle").scale += Vector2(0.1, 0.1)
	yield(get_tree().create_timer(change, false), "timeout")
	get_node("circle").scale += Vector2(0.1, 0.1)
	yield(get_tree().create_timer(change, false), "timeout")
	get_node("circle").scale += Vector2(0.1, 0.1)
	yield(get_tree().create_timer(change, false), "timeout")
	get_node("circle").scale += Vector2(0.1, 0.1)
	yield(get_tree().create_timer(change, false), "timeout")
	get_node("circle").scale += Vector2(0.1, 0.1)
	yield(get_tree().create_timer(change, false), "timeout")
	get_node("circle").scale += Vector2(0.1, 0.1)
	yield(get_tree().create_timer(change, false), "timeout")
	get_node("circle").scale += Vector2(0.1, 0.1)
	yield(get_tree().create_timer(change, false), "timeout")
	get_node("circle").scale = Vector2.ZERO

