extends Control

func _ready():
	$version/version.text = Global.version

func _on_Exit_pressed():
	Audio.get_node("click").play()
	get_tree().change_scene("res://scenes/Main Menu.tscn")
	if Global.graphics:
		$WorldEnvironment.environment.glow_enabled = true
	else:
		$WorldEnvironment.environment.glow_enabled = false


func _on_madeby_pressed():
	Audio.get_node("click").play()
	OS.shell_open("https://ironwood.itch.io")


func _on_godot_pressed():
	Audio.get_node("click").play()
	OS.shell_open("https://godotengine.org/")


func _on_djam5_pressed():
	Audio.get_node("click").play()
	OS.shell_open("https://itch.io/jam/discord-jam-5/rate/873317")


func _on_music_pressed():
	Audio.get_node("click").play()
	OS.shell_open("https://www.fesliyanstudios.com/")


func _on_jfxr_pressed():
	Audio.get_node("click").play()
	OS.shell_open("https://jfxr.frozenfractal.com/")


func _on_anniversary_pressed():
	Audio.get_node("click").play()
	OS.shell_open("https://www.dafont.com/anniversary.font")


func _on_roboto_pressed():
	Audio.get_node("click").play()
	OS.shell_open("https://fonts.google.com/specimen/Roboto")


func _on_license_pressed():
	Audio.get_node("click").play()
	OS.shell_open("https://creativecommons.org/licenses/by-sa/4.0/legalcode")
