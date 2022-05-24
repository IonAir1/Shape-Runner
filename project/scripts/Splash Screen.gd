extends Control


export var wait_time = 2.5
func _ready():
	yield(get_tree().create_timer(wait_time), "timeout")
	get_tree().change_scene("res://scenes/Main Menu.tscn")
