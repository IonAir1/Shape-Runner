extends Control


func _ready():
	if Global.first:
		Global.load_score()
		Global.load_settings()
		Global.first = false
	if Global.death_sound:
		Global.death_sound = false
		Audio.get_node("lost").play()

	if Global.score > Global.bestscore: #set score
		Global.bestscore = Global.score
		Global.save_score()
	
	if Global.graphics:
		$WorldEnvironment.environment.glow_enabled = true
	else:
		$WorldEnvironment.environment.glow_enabled = false
	
	get_node("Center/UI/VBoxContainer/score").text = "SCORE      " + str(Global.score)
	get_node("Center/UI/VBoxContainer/best").text = "BEST SCORE      " + str(Global.bestscore)


func _on_play_pressed(): #play
	get_tree().change_scene("res://scenes/main.tscn")

func _on_settings_pressed():
	get_tree().change_scene("res://scenes/Settings.tscn")

func _on_credits_pressed():
	get_tree().change_scene("res://scenes/Credits.tscn")
