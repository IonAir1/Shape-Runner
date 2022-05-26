extends Node2D

var pause = preload("res://assets/pause.png")
var play = preload("res://assets/play.png")
var disable = false #disable toggle
var death_delay = false

func _ready():
	Global.end = false
	$text.visible = false
	$TouchScreenButton.normal = pause
	yield(get_tree().create_timer(0.5, false), "timeout")
	death_delay = true

func _process(delta):
	get_parent().resize(get_viewport_rect().size.x, get_viewport_rect().size.y) #resize game based on screen size
	$text.global_position.x = get_viewport_rect().size.x / 2 #reposition pause text based on screen size


	if Input.is_action_just_released("pause"): #keyboard pause
		toggle()


	if Global.end and death_delay: #if game end
		Global.end = false
		disable = true
		get_tree().paused = true
		Global.death_fade = true
		get_parent().get_node("obstacle").position = Vector2(-1000,-1000)
		get_parent().get_node("Player/circle").visible = false
		Audio.get_node("explosion").play()
		if Global.graphics:
			get_parent().get_node("Camera2D").shake(0.5, 30, 8)
			get_parent().get_node("Player/Running").pause_mode = Node.PAUSE_MODE_PROCESS
			get_parent().get_node("Player/Running_reversed").pause_mode = Node.PAUSE_MODE_PROCESS
			get_parent().get_node("Player/Flying").pause_mode = Node.PAUSE_MODE_PROCESS
			get_parent().get_node("Player/Swimming").pause_mode = Node.PAUSE_MODE_PROCESS
			if Global.state == 0 or Global.state == 4 or Global.state == 5:
				get_parent().get_node("Player/Run_Explosion").emitting = true
			elif Global.state == 1 or Global.state == 3 or Global.state == 6:
				get_parent().get_node("Player/Fly_Explosion").emitting = true
			else:
				get_parent().get_node("Player/Swim_Explosion").emitting = true
		
		get_parent().get_node("Player/sprite").visible = false
		yield(get_tree().create_timer(1), "timeout")
		fade(10)
		yield(get_tree().create_timer(0.35), "timeout")
		get_tree().paused = false
		get_tree().change_scene("res://scenes/Main Menu.tscn")


func toggle(): #toggle pause
	if !disable:
		if get_tree().paused:
			$text/Number.visible = true
			$text/Number.text = "3"
			yield(get_tree().create_timer(1),"timeout")
			$text/Number.text = "2"
			yield(get_tree().create_timer(1),"timeout")
			$text/Number.text = "1"
			yield(get_tree().create_timer(1),"timeout")
			get_tree().paused = false
			$text.visible = false
			$TouchScreenButton.normal = pause
		else:
			get_tree().paused = true
			$text.visible = true
			$text/Number.visible = false
			$TouchScreenButton.normal = play

func _on_TouchScreenButton_pressed(): #pause button
	Audio.get_node("click").play()
	toggle()

func fade(number): #fade, scene transition
	var a = (10 - number) * 0.1
	get_parent().get_node("fade").modulate = Color(0,0,0, a)
	yield(get_tree().create_timer(0.02),"timeout")
	fade(number - 1)
