extends RigidBody2D

var speed = 10
var size
var bounciness

func _ready():
	gravity_scale = bounciness
	$Area2D.scale = Vector2(size, size)	
	$CollisionShape2D.scale = Vector2(size, size)

func _physics_process(delta):
	position.x -= speed
	
	if Global.state == 5:
		$Area2D.scale.x -= 0.1
		$Area2D.scale.y -= 0.1
		$CollisionShape2D.scale.x -= 0.1
		$CollisionShape2D.scale.y -= 0.1
	if $Area2D.scale.x < 0.1:
		queue_free()
	
	if global_position.x < -100:
		queue_free()


func _on_Area2D_area_entered(area):
	Global.end = true
