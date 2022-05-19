extends Node2D

var running_obstacle = preload("res://scenes/runner obstacle.tscn")
var running_script = preload("res://scripts/runner obstacle.gd")
var flying_obstacle = preload("res://scenes/flying obstacle.tscn")
var flying_script = preload("res://scripts/flying obstacle.gd")
var swim_obstacle = preload("res://scenes/swim_obstacle.tscn")
var swim_script = preload("res://scripts/swim_obstacle.gd")
var water_rise = 0.1 #speed of water rising
var velocity = 0 #velocity
var change = 0.3 #speed of transition
var vprect = Vector2()


func _process(delta):
	if not vprect.x == get_viewport_rect().size.x or not vprect.y == get_viewport_rect().size.y:
		position.x = (get_viewport_rect().size.x - (get_node("ground/ground").texture.get_size().x*5.33333))
		position.y = (get_viewport_rect().size.y / 2) - (get_node("ground/ground").texture.get_size().y / 2) - 240
		$score.set_global_position(Vector2(50, 50))
	vprect = get_viewport_rect().size


func obstacle_spawn(): #spawns obstacles
	if Global.state == 0: #spawns game A obstacle
		var e = running_obstacle.instance()
		e.position = Vector2(1330, 692)
		e.set_script(running_script)
		var a = Vector2(rand_range(0.2, 0.6), rand_range(0.2, 0.6))
		e.size = a.normalized()
		e.game = 1
		add_child(e)
		var wait = rand_range(0.8, 3)
		yield(get_tree().create_timer(wait), "timeout")
		
		
	elif Global.state == 1: #spawns game B obstacle
		var e = flying_obstacle.instance()
		e.position = Vector2(1400, rand_range(112, 608))
		e.set_script(flying_script)
		add_child(e)
		var wait = rand_range(1, 2.3)
		yield(get_tree().create_timer(wait), "timeout")
	
	
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
		e.a = a
		add_child(e)
		var wait = rand_range(1.3, 3)
		yield(get_tree().create_timer(wait), "timeout")


	if Global.state == 3: #spawns game D obstacle
		var e = running_obstacle.instance()
		e.position = Vector2(1326, rand_range(20, 700))
		e.set_script(flying_script)
		add_child(e)
		var wait = rand_range(0.2, 0.4)
		yield(get_tree().create_timer(wait), "timeout")


	obstacle_spawn()


func _ready():
	randomize()
	Global.score = 0
	Global.state = 0
	yield(get_tree().create_timer(1), "timeout")
	obstacle_spawn()
	mutate()
	score()


func score(): #adds score
	yield(get_tree().create_timer(5), "timeout")
	Global.score += 50
	score()


func mutate(): #mutates/changes game
	var wait = rand_range(5,10)
	yield(get_tree().create_timer(wait), "timeout")
	get_node("sounds/mutate").play()
	get_node("obstacle").position = Vector2(624,393)
	yield(get_tree().create_timer(change), "timeout")
	get_node("obstacle").position = Vector2(-1000,-1000)
	yield(get_tree().create_timer(change), "timeout")
	get_node("obstacle").position = Vector2(624,393)
	yield(get_tree().create_timer(change), "timeout")
	get_node("obstacle").position = Vector2(-1000,-1000)
	yield(get_tree().create_timer(change), "timeout")
	get_node("obstacle").position = Vector2(624,393)
	yield(get_tree().create_timer(change), "timeout")
	get_node("obstacle").position = Vector2(-1000,-1000)
	yield(get_tree().create_timer(change), "timeout")
	get_node("obstacle").position = Vector2(624,393)
	Global.new = true
	yield(get_tree().create_timer(change), "timeout")
	get_node("obstacle").position = Vector2(-1000,-1000)
	Global.mutate = true
	mutate()


func _physics_process(delta):
	if Global.state < 2: #code for water rising and lowering
		get_node("water").position = Vector2(635, 1278)
	if Global.switch_to_c:
		Global.switch_to_c = false
		velocity = 85
	velocity = lerp(velocity, 0, water_rise)
	if Global.switch_to_d:
		Global.switch_to_d = false
		velocity = 100
	velocity = lerp(velocity, 0, water_rise)
	if velocity > 0:
		get_node("water").position -= Vector2(0, velocity)


	get_node("score/Score").text = str(Global.score)
	if Global.end:
		Global.end = false
		get_tree().change_scene("res://scenes/Main Menu.tscn")


func _on_touch_pressed():
		if get_global_mouse_position().y < (OS.get_window_size().y/2):
			$Player.touch = 1
		else:
			$Player.touch = -1


func _on_touch_released():
	$Player.touch = 0
