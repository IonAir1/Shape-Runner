extends Control


func _on_Exit_pressed():
	get_tree().change_scene("res://scenes/Main Menu.tscn")
	if Global.graphics:
		$WorldEnvironment.environment.glow_enabled = true
	else:
		$WorldEnvironment.environment.glow_enabled = false
