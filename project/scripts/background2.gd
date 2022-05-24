extends Node2D

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

func spawn(): #spawns running obstacle in main menu
	var e = flying_obstacle.instance()
	var height = rand_range(112, 608)
	delay_move(height)
	e.position = Vector2(1400, height)
	e.set_script(flying_script)
	add_child(e)
	yield(get_tree().create_timer(1.5,3),"timeout")
	spawn()

func delay_move(height):
	yield(get_tree().create_timer(0.25), "timeout")
	$Player.y_destination = height
