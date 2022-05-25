extends KinematicBody2D


var dir = 0 #direction
var friction = 0.2 #running friction
var acceleration = 0.25 #running acceleration
var velocity = Vector2.ZERO #velocity
var vertical_speed = 800 #vertical player speed
var y_destination = 360

func _ready():
	position.y = y_destination
	#print(get_tree().get_current_scene().get_name())

func _physics_process(delta):
	if Global.graphics:
		modulate = Color(1.2, 1.2, 1.2, 1)
		$Flying.emitting = true
		$Flying.visible = true
	else:
		modulate = Color(1,1,1,1)
		$Flying.emitting = false
		$Flying.visible = false
	var dir = 0
	if (y_destination - 30) > position.y:
		dir += 1
	if (y_destination + 30) < position.y:
			dir -= 1
	if dir != 0:
		velocity.y = lerp(velocity.y, dir * vertical_speed, acceleration)
	else:
		velocity.y = lerp(velocity.y, 0, friction)
	velocity = move_and_slide(velocity, Vector2.UP)
