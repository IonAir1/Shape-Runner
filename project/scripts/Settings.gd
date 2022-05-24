extends Control

var pressed = Color(1,1,1,1)
var darkened = Color(0.5,0.5,0.5,1)


func _ready():
	pass

func _process(delta):
	if Global.sounds:
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
	else:
		get_node("MarginContainer/VBoxContainer/CenterContainer/Lower/2nd Set/Graphics").text = "fast graphics"




func _on_Exit_pressed():
	get_tree().change_scene("res://scenes/Main Menu.tscn")


func _on_Sounds_pressed():
	if Global.sounds:
		Global.sounds = false
	else:
		Global.sounds = true
	Global.save_settings()


func _on_Music_pressed():
	if Global.music:
		Global.music = false
	else:
		Global.music = true
	Global.save_settings()


func _on_Button_Guide_pressed():
	if Global.guide:
		Global.guide = false
	else:
		Global.guide = true
	Global.save_settings()


func _on_Graphics_pressed():
	if Global.graphics:
		Global.graphics = false
	else:
		Global.graphics = true
	Global.save_settings()
