extends KinematicBody2D

var speed = 1200 #speed
var gravity = 4000 #gravity
var velocity = Vector2.ZERO #velocity
var a = -1 #type


func _ready():
	if a > -1:
		if a == 0: #setting up top obstacle
			get_node("Bottom2").queue_free()
			get_node("Middle2").queue_free()
			get_node("Area2D/Middle").queue_free()
			get_node("Area2D/Bottom").queue_free()
		if a == 1: #setting up middle obstacle
			get_node("Bottom2").queue_free()
			get_node("Top2").queue_free()
			get_node("Area2D/Top").queue_free()
			get_node("Area2D/Bottom").queue_free()
		if a == 2: #setting up bottom obstacle
			get_node("Top2").queue_free()
			get_node("Middle2").queue_free()
			get_node("Area2D/Middle").queue_free()
			get_node("Area2D/Top").queue_free()


func _physics_process(delta):
	velocity.x = -1 * speed #move
	velocity = move_and_slide(velocity, Vector2.UP)
	if global_position.x < -400:
		queue_free()
	if Global.dev and Input.is_action_just_pressed("enter"):
		speed == 0

func _on_Area2D_area_entered(area): #game end
	Global.end = true
