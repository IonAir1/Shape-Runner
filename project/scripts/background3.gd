extends Node2D

var swim_obstacle = preload("res://scenes/swim obstacle.tscn")
var swim_script = preload("res://scripts/swim obstacle.gd")
var flying_script = preload("res://scripts/settings obstacle.gd")
var flying_obstacle = preload("res://scenes/flying obstacle.tscn")
var vprect = Vector2()


func _process(delta):
	if not vprect.x == get_viewport_rect().size.x or not vprect.y == get_viewport_rect().size.y:
		position.x = (get_viewport_rect().size.x - ($ground/ground.texture.get_size().x*5.33333))
		position.y = (get_viewport_rect().size.y / 2) - ($ground/ground.texture.get_size().y / 2) - 240
	vprect = get_viewport_rect().size

func _ready():
	yield(get_tree().create_timer(1), "timeout")
	spawn()

func spawn():
	var e = swim_obstacle.instance()
	var a = randi()%3
	if a == 0:
		e.position = Vector2(1600,320)
		if Global.graphics:
			e.modulate = Color(1.5, 3, 1.8, 1)
	if a == 1:
		e.position = Vector2(1600,400)
		if Global.graphics:
			e.modulate = Color(1.5, 3, 1.8, 1)
	if a == 2:
		e.position = Vector2(1600,515)
		if Global.graphics:
			e.modulate = Color(1.5, 3, 1.8, 1)
	e.set_script(swim_script)
	e.a = a
	add_child(e)
	yield(get_tree().create_timer(rand_range(1.3, 3)),"timeout")
	spawn()



