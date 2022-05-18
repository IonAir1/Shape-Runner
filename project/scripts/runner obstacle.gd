extends KinematicBody2D

var speed = 1200
var jump_speed = -1000
var gravity = 4000
var size = Vector2.ZERO
var velocity = Vector2.ZERO
var game

func _ready():
	scale = size

func _physics_process(delta):
	velocity.x = -1 * speed #move
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	if position.x < -100:
		queue_free()



func _on_Area2D_area_entered(area):
	if game == 1:
		Global.end = true
