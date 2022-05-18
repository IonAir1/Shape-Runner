extends KinematicBody2D

var speed = 1200
var gravity = 4000
var velocity = Vector2.ZERO
var a = -1


func _ready():
	if a > -1:
		if a == 0:
			get_node("Bottom2").queue_free()
			get_node("Middle2").queue_free()
			get_node("Area2D/Middle").queue_free()
			get_node("Area2D/Bottom").queue_free()
		if a == 1:
			get_node("Bottom2").queue_free()
			get_node("Top2").queue_free()
			get_node("Area2D/Top").queue_free()
			get_node("Area2D/Bottom").queue_free()
		if a == 2:
			get_node("Top2").queue_free()
			get_node("Middle2").queue_free()
			get_node("Area2D/Middle").queue_free()
			get_node("Area2D/Top").queue_free()


func _physics_process(delta):
	velocity.x = -1 * speed
	velocity = move_and_slide(velocity, Vector2.UP)
	if position.x < -400:
		queue_free()
	if Global.dev == 1 and Input.is_action_just_pressed("enter"):
		speed == 0

func _on_Area2D_area_entered(area):
	get_tree().change_scene("res://scenes-scripts/Main Menu.tscn")
