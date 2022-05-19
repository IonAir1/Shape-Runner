extends Control


func _ready():
	if Global.first:
		Global.first = false
	else:
		get_node("lost").play()
	if Global.score > Global.bestscore: #set score
		Global.bestscore = Global.score
	get_node("Center/UI/VBoxContainer/score").text = "SCORE      " + str(Global.score)
	get_node("Center/UI/VBoxContainer/best").text = "BEST SCORE      " + str(Global.bestscore)

func _on_play_pressed(): #play
	get_tree().change_scene("res://scenes/main.tscn")

