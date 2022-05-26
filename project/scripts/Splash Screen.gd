extends Control

export var wait_time = 2

func _ready():
	yield(get_tree().create_timer(wait_time), "timeout")
	Global.load_score()
	Global.load_settings()
	get_tree().change_scene("res://scenes/Main Menu.tscn")
