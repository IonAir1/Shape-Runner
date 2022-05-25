extends Node2D

var running_obstacle = preload("res://scenes/runner obstacle.tscn")
var running_script = preload("res://scripts/runner obstacle.gd")
var flying_obstacle = preload("res://scenes/flying obstacle.tscn")
var flying_script = preload("res://scripts/flying obstacle.gd")
var swim_obstacle = preload("res://scenes/swim obstacle.tscn")
var swim_script = preload("res://scripts/swim obstacle.gd")
var bounce_obstacle = preload("res://scenes/bouncing obstacle.tscn")
var bounce_script = preload("res://scripts/bouncing obstacle.gd")
var water_rise = 0.1 #speed of water rising
var velocity = 0 #water velocity
var change = 0.3 #speed of transition
var vprect = Vector2()
var waterlower
var waterrepos = false
var wait = 1
var mutate = Vector2(5, 12)
var startingstate = 0
var twobuttons = [1, 2, 3, 6]

func _process(delta):
	if Global.guide:
		if twobuttons.find(Global.state) != -1:
			get_node("buttons/1").visible = false
			get_node("buttons/2").visible = true
		else:
			get_node("buttons/1").visible = true
			get_node("buttons/2").visible = false

func resize():
	if not vprect.x == get_viewport_rect().size.x or not vprect.y == get_viewport_rect().size.y:
		position.x = (get_viewport_rect().size.x - (get_node("ground/ground").texture.get_size().x*5.33333))
		position.y = (get_viewport_rect().size.y / 2) - (get_node("ground/ground").texture.get_size().y / 2) - 240
		$score.set_global_position(Vector2(70, 70))
	vprect = get_viewport_rect().size


func obstacle_spawn(): #spawns obstacles
	if Global.state == 0: #spawns game A obstacle
		var e = running_obstacle.instance()
		e.position = Vector2(1330, 692)
		e.set_script(running_script)
		var a = Vector2(rand_range(0.2, 0.6), rand_range(0.2, 0.6))
		e.size = a.normalized()
		e.game = 1
		e.gravitydir = -1
		if Global.graphics:
			e.modulate = Color(1.5, 3, 1.8, 1)
		add_child(e)
		wait = rand_range(0.8, 3)


	elif Global.state == 1: #spawns game B obstacle
		var e = flying_obstacle.instance()
		e.position = Vector2(1400, rand_range(112, 608))
		e.set_script(flying_script)
		if Global.graphics:
			e.modulate = Color(1.5, 3, 1.8, 1)
		add_child(e)
		wait = rand_range(1, 2.3)


	elif Global.state == 2: #spawns game C obstacle
		var e = swim_obstacle.instance()
		var a = randi()%3
		if a == 0:
			e.position = Vector2(1600,320)
		if a == 1:
			e.position = Vector2(1600,400)
		if a == 2:
			e.position = Vector2(1600,515)
		e.set_script(swim_script)
		if Global.graphics:
			e.modulate = Color(1.5, 3, 1.8, 1)
		e.a = a
		add_child(e)
		wait = rand_range(1.3, 3)



	if Global.state == 3: #spawns game D obstacle
		var e = running_obstacle.instance()
		e.position = Vector2(1326, rand_range(20, 700))
		e.set_script(flying_script)
		if Global.graphics:
			e.modulate = Color(2, 4, 2.4, 1)
		add_child(e)
		wait = rand_range(0.2, 0.4)


	if Global.state == 4:
		var e = bounce_obstacle.instance()
		var height = rand_range(300, 600)
		e.position = Vector2(1330, height)
		e.set_script(bounce_script)
		e.size = rand_range(3, 15) / 10
		e.bounciness = rand_range(6, 15)
		if Global.graphics:
			e.modulate = Color(1.5, 3, 1.8, 1)
		add_child(e)
		wait = rand_range(1, 2.8)


	if Global.state == 5:
		var e = running_obstacle.instance()
		var gravitydir = (randi()%3) - 1
		if gravitydir != 0:
			e.set_script(running_script)
			if gravitydir < 0:
				e.position = Vector2(1330, 693)
				e.gravitydir = -1
			else:
				e.position = Vector2(1330, 20)
				e.gravitydir = 1
			e.size = Vector2(0.6, 0.6)
			e.game = 1
			if Global.graphics:
				e.modulate = Color(1.5, 3, 1.8, 1)
			add_child(e)
		wait = rand_range(0.2, 1)



	if Global.state == 6:
		var e = running_obstacle.instance()
		e.position = Vector2(1400, rand_range(0, 720))
		e.set_script(flying_script)
		if Global.graphics:
			e.modulate = Color(1.5, 3, 1.8, 1)
		add_child(e)
		wait = rand_range(0.4, 1)


	yield(get_tree().create_timer(wait, false), "timeout")
	obstacle_spawn()


func _ready():
	randomize()
	Global.score = 0
	Global.state = startingstate
	if !Global.guide:
		$buttons.visible = false
		$buttons.visible = false
	if Global.graphics:
		$WorldEnvironment.environment.glow_enabled = true
	else:
		$WorldEnvironment.environment.glow_enabled = false
	yield(get_tree().create_timer(1, false), "timeout")
	obstacle_spawn()
	mutate()
	score()


func score(): #adds score
	yield(get_tree().create_timer(5, false), "timeout")
	Global.score += 50
	score()


func mutate(): #mutates/changes game
	var wait = rand_range(mutate.x, mutate.y)
	yield(get_tree().create_timer(wait, false), "timeout")
	get_node("obstacle").position = Vector2(624,393)
	yield(get_tree().create_timer(change, false), "timeout")
	get_node("obstacle").position = Vector2(-1000,-1000)
	yield(get_tree().create_timer(change, false), "timeout")
	get_node("obstacle").position = Vector2(624,393)
	yield(get_tree().create_timer(change, false), "timeout")
	get_node("obstacle").position = Vector2(-1000,-1000)
	yield(get_tree().create_timer(change, false), "timeout")
	get_node("obstacle").position = Vector2(624,393)
	yield(get_tree().create_timer(change, false), "timeout")
	get_node("obstacle").position = Vector2(-1000,-1000)
	yield(get_tree().create_timer(change, false), "timeout")
	get_node("obstacle").position = Vector2(624,393)
	Global.new = true
	yield(get_tree().create_timer(change, false), "timeout")
	get_node("obstacle").position = Vector2(-1000,-1000)
	Audio.get_node("mutate").play()
	Global.mutate = true
	
	mutate()


func _physics_process(delta):
	if Global.switch_to_c: #code for water rising and lowering
		Global.switch_to_c = false
		velocity = 85
	velocity = lerp(velocity, 0, water_rise)
	if Global.switch_to_d:
		Global.switch_to_d = false
		velocity = 100
	velocity = lerp(velocity, 0, water_rise)
	if Global.switch_to_e:
		Global.switch_to_e = false
		velocity = -185
		waterlower = get_tree().create_timer(3)
		waterrepos = true
	if Global.state == 0:
		$water.position.y = 1600
	

	if velocity != 0:
		get_node("water").position -= Vector2(0, velocity)
	elif Global.state == 4 and waterrepos:
		if  waterlower.time_left <= 0:
			waterrepos = false
			get_node("water").position = Vector2(635, 1278)


	get_node("score/Score").text = str(Global.score)



func _on_touch_pressed():
		if get_global_mouse_position().y < (get_viewport_rect().size.y / 2):
			$Player.touch = 1
		else:
			$Player.touch = -1


func _on_touch_released():
	$Player.touch = 0
