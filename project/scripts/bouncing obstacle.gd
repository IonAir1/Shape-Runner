extends RigidBody2D

var speed = 10 #horizontal speed
var size #size
var bounciness #bounciness

func _ready():
	gravity_scale = bounciness #scales the ball
	$Area2D.scale = Vector2(size, size)	
	$CollisionShape2D.scale = Vector2(size, size)

func _physics_process(delta):
	position.x -= speed #moves the ball to the left
	
	if Global.state == 5: #if game mutates, make transition and despawn
		$Area2D.scale.x -= 0.1
		$Area2D.scale.y -= 0.1
		$CollisionShape2D.scale.x -= 0.1
		$CollisionShape2D.scale.y -= 0.1
	if $Area2D.scale.x < 0.1:
		queue_free()
	
	if global_position.x < -100: #despawn when off screen
		queue_free()


func _on_Area2D_area_entered(area): #game end
	Global.end = true
