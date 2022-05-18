extends Node2D


var running_obstacle = preload("res://scenes-scripts/runner obstacle.tscn")
var running_script = preload("res://scenes-scripts/runner obstacle.gd")


func _ready():
	yield(get_tree().create_timer(1), "timeout")
	spawn()

func spawn():
	var e = running_obstacle.instance()
	e.position = Vector2(1330, 600)
	e.set_script(running_script)
	var a = Vector2(rand_range(0.2, 0.6), rand_range(0.2, 0.6))
	e.size = a.normalized()
	add_child(e)
	var wait = rand_range(0.8, 3)
	yield(get_tree().create_timer(wait), "timeout")
	spawn()
