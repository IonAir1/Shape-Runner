extends KinematicBody2D

var jump_speed = -1300 #jump speed
var gravity = 4000 #gravity
var swim_jump = false #timer for disabling jumping when game C
var velocity = Vector2.ZERO #velocity
var top_detect = false
var middle_detect = false
var bottom_detect = false
var dir = 0

func _physics_process(delta):
	if top_detect:
		dir = -1
	elif bottom_detect:
		dir = 1
	elif middle_detect:
		dir = randi()%3
		if dir == 2:
			dir = -1


	jump_speed = -600
	gravity = 950
	if position.y > 380 and position.y < 420 and not swim_jump:
		position.y = 400
		velocity.y = 0
	elif position.y < 400:
		velocity.y += gravity * delta
	elif position.y > 400:
		velocity.y -= gravity * delta
	elif position.y == 400:
		velocity.y = 0
	if dir == 1:
		dir = 0
		if position.y == 400 and not swim_jump:
			velocity.y = jump_speed
			swim_jump = true
			swimwait()
			Audio.get_node("jump").play()
	if dir == -1:
		dir = 0
		if position.y == 400 and not swim_jump:
			velocity.y = jump_speed * -1
			swim_jump = true
			swimwait()
			Audio.get_node("dive").play()
	velocity = move_and_slide(velocity, Vector2.UP)

func swimwait():#timer for game C, jumping
	yield(get_tree().create_timer(0.5), "timeout")
	top_detect = false
	middle_detect = false
	bottom_detect = false
	swim_jump = false

func _on_middle_area_entered(area):
	middle_detect = true

func _on_top_area_entered(area):
	top_detect = true

func _on_bottom_area_entered(area):
	bottom_detect = true
