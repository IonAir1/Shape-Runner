extends Node2D


var running_obstacle = preload("res://scenes/runner obstacle.tscn")
var running_script = preload("res://scripts/runner obstacle.gd")
var vprect = Vector2()


func _process(delta): #reposition background based on screen size
	if not vprect.x == get_viewport_rect().size.x or not vprect.y == get_viewport_rect().size.y:
		position.x = (get_viewport_rect().size.x - ($ground.texture.get_size().x*5.33333))
		position.y = (get_viewport_rect().size.y / 2) - ($ground.texture.get_size().y / 2) - 240
	vprect = get_viewport_rect().size

func _ready():
	yield(get_tree().create_timer(1), "timeout")
	spawn()

func spawn(): #spawns running obstacle in main menu
	var e = running_obstacle.instance()
	e.position = Vector2(1330, 692)
	e.set_script(running_script)
	var a = Vector2(rand_range(0.2, 0.6), rand_range(0.2, 0.6)) #random size
	e.size = a.normalized()
	e.game = 0
	e.gravitydir = -1
	if Global.graphics:
		e.modulate = Color(1.5, 3, 1.8, 1)
	add_child(e)
	var wait = rand_range(0.8, 3)
	yield(get_tree().create_timer(wait), "timeout")
	spawn()
