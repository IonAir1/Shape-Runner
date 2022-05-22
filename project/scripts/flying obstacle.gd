extends KinematicBody2D

var speed = 1200
var gravity = 4000
var velocity = Vector2.ZERO

func _physics_process(delta):
	velocity.x = -1 * speed #movement
	velocity = move_and_slide(velocity, Vector2.UP)
	if global_position.x < -200 or (Global.state != 1 and Global.state != 3 and Global.state !=6):
		queue_free()


func _ready():
	if Global.state == 6:
		scale = Vector2(1.6, 1.6)




func _on_Area2D_area_entered(area): #game end
	Global.end = true
