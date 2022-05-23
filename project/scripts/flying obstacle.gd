extends KinematicBody2D

var speed = 1200
var gravity = 4000
var velocity = Vector2.ZERO
var mutate = true

func _physics_process(delta):
	velocity.x = -1 * speed #movement
	velocity = move_and_slide(velocity, Vector2.UP)
	if global_position.x < -200:# or (Global.state != 1 and Global.state != 3 and Global.state !=6):
		queue_free()
	if Global.state == 2:
		if mutate == true:
			mutate = false
			$Area2D.queue_free()
		$upper.position.y -= 12
		$lower.position.y += 12
		timerdelete()
	if Global.state == 0:
		scale.x -= 0.1
		scale.y -= 0.1
	if Global.state == 4:
		scale.x -= 0.01
		scale.y -= 0.01
	if scale.x < 0.1:
		queue_free()

func timerdelete():
	yield(get_tree().create_timer(4), "timeout")
	queue_free()


func _ready():
	if Global.state == 6:
		scale = Vector2(1.6, 1.6)




func _on_Area2D_area_entered(area): #game end
	Global.end = true
