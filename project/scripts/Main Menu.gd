extends Control

func _ready():
	if Global.first: #load saves
		Global.load_score()
		Global.load_settings()
		Global.first = false

	if Global.death_fade: #death fade scene transition
		Global.death_fade = false
		$fade.modulate = Color(0,0,0,1)
		fade(10)

	Global.state = 0
	if Global.score > Global.bestscore: #set score
		Global.bestscore = Global.score
		Global.save_score()
	
	if Global.graphics: #fancy graphics
		$WorldEnvironment.environment.glow_enabled = true
	else:
		$WorldEnvironment.environment.glow_enabled = false
	
	get_node("Center/UI/VBoxContainer/score").text = "SCORE      " + str(Global.score) #score and highscore
	get_node("Center/UI/VBoxContainer/best").text = "BEST SCORE      " + str(Global.bestscore)

func fade(number): #fade
	if number > 0:
		var a = number * 0.1
		$fade.modulate = Color(0,0,0, a)
		yield(get_tree().create_timer(0.02),"timeout")
		fade(number - 1)
	else:
		$fade.modulate = Color(0,0,0,0)

func _on_play_pressed(): #play button
	Audio.get_node("click").play()
	get_tree().change_scene("res://scenes/main.tscn")

func _on_settings_pressed(): #settings button
	Audio.get_node("click").play()
	get_tree().change_scene("res://scenes/Settings.tscn")

func _on_credits_pressed(): #credits button
	Audio.get_node("click").play()
	get_tree().change_scene("res://scenes/Credits.tscn")
