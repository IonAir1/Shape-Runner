extends Node2D

var running_obstacle = preload("res://scenes/runner obstacle.tscn")
var running_script = preload("res://scripts/runner obstacle.gd")
var flying_obstacle = preload("res://scenes/flying obstacle.tscn")
var flying_script = preload("res://scripts/flying obstacle.gd")
var swim_obstacle = preload("res://scenes/swim_obstacle.tscn")
var swim_script = preload("res://scripts/swim_obstacle.gd")
var water_rise = 0.1
var velocity = 0
var change = 0.3

func obstacle_spawn():
	
	if Global.state == 0:
		var e = running_obstacle.instance()
		e.position = Vector2(1330, 600)
		e.set_script(running_script)
		var a = Vector2(rand_range(0.2, 0.6), rand_range(0.2, 0.6))
		e.size = a.normalized()
		e.game = 1
		add_child(e)
		var wait = rand_range(0.8, 3)
		yield(get_tree().create_timer(wait), "timeout")
		
		
	elif Global.state == 1:
		var e = flying_obstacle.instance()
		e.position = Vector2(1400, rand_range(112, 530))
		e.set_script(flying_script)
		add_child(e)
		var wait = rand_range(1, 2.3)
		yield(get_tree().create_timer(wait), "timeout")
	
	
	elif Global.state == 2:
		var e = swim_obstacle.instance()
		var a = randi()%3
		if a == 0:
			e.position = Vector2(1400,320)
		if a == 1:
			e.position = Vector2(1400,400)
		if a == 2:
			e.position = Vector2(1400,515)
		e.set_script(swim_script)
		e.a = a
		add_child(e)
		var wait = rand_range(1.3, 3)
		yield(get_tree().create_timer(wait), "timeout")


	if Global.state == 3:
		var e = running_obstacle.instance()
		e.position = Vector2(1326, rand_range(20, 600))
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


func score():
	yield(get_tree().create_timer(5), "timeout")
	Global.score += 50
	score()


func mutate():
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
	if Global.state < 2:
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
