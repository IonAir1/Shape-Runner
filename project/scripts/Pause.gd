extends Node2D

var pause = preload("res://assets/pause.png")
var play = preload("res://assets/play.png")

func _ready():
	$text.visible = false
	$TouchScreenButton.normal = pause

func _process(delta):
	get_parent().resize()
	$text.global_position.x = get_viewport_rect().size.x / 2
	if Input.is_action_just_released("pause"):
		toggle()

func toggle():
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

func _on_TouchScreenButton_pressed():
	toggle()
