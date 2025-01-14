extends Control

var pressed = Color(1.1,1.1,1.1,1)
var darkened = Color(0.5,0.5,0.5,1)


func _ready():
	$background/version.text = "Version " + Global.version #display version number
	get_node("MarginContainer/VBoxContainer/CenterContainer/Lower/2nd Set/Graphics").modulate = pressed

func _process(delta):
	if Global.sounds: #button visuals
		get_node("MarginContainer/VBoxContainer/CenterContainer/Lower/1st Set/Sounds").modulate = pressed
	else:
		get_node("MarginContainer/VBoxContainer/CenterContainer/Lower/1st Set/Sounds").modulate = darkened
	if Global.music:
		get_node("MarginContainer/VBoxContainer/CenterContainer/Lower/1st Set/Music").modulate = pressed
	else:
		get_node("MarginContainer/VBoxContainer/CenterContainer/Lower/1st Set/Music").modulate = darkened
	if Global.guide:
		get_node("MarginContainer/VBoxContainer/CenterContainer/Lower/2nd Set/Guide").modulate = pressed
	else:
		get_node("MarginContainer/VBoxContainer/CenterContainer/Lower/2nd Set/Guide").modulate = darkened
	if Global.graphics:
		get_node("MarginContainer/VBoxContainer/CenterContainer/Lower/2nd Set/Graphics").text = "fancy graphics"
		$WorldEnvironment.environment.glow_enabled = true
	else:
		get_node("MarginContainer/VBoxContainer/CenterContainer/Lower/2nd Set/Graphics").text = "fast graphics"
		$WorldEnvironment.environment.glow_enabled = false




func _on_Exit_pressed():
	Audio.get_node("click").play()
	get_tree().change_scene("res://scenes/Main Menu.tscn")


func _on_Sounds_pressed():
	if Global.sounds:
		Global.sounds = false
	else:
		Global.sounds = true
		delayed_sound(0.05)
	Global.save_settings()

func delayed_sound(delay):
	yield(get_tree().create_timer(delay),"timeout")
	Audio.get_node("click").play()

func _on_Music_pressed():
	Audio.get_node("click").play()
	if Global.music:
		Global.music = false
	else:
		Global.music = true
	Global.save_settings()


func _on_Button_Guide_pressed():
	Audio.get_node("click").play()
	if Global.guide:
		Global.guide = false
	else:
		Global.guide = true
	Global.save_settings()


func _on_Graphics_pressed():
	Audio.get_node("click").play()
	if Global.graphics:
		Global.graphics = false
	else:
		Global.graphics = true
	Global.save_settings()
