extends CharacterBody2D

signal took_damage

var force = 300
var rocket_scene = preload("res://scenes/rocket.tscn")

@onready var rocket_container = $RocketContainer

func _process(_delta):
	if Input.is_action_just_pressed("shoot"):
		shoot_rocket()

func _physics_process(_delta):
	velocity = Vector2(0,0)
	
	if Input.is_action_pressed("up_input"):
		velocity.y = -force
	if Input.is_action_pressed("down_input"):
		velocity.y = force
	if Input.is_action_pressed("right_input"):
		velocity.x = force
	if Input.is_action_pressed("left_input"):
		velocity.x = -force
	move_and_slide()
		
	var screen_size = get_viewport_rect().size
	global_position = global_position.clamp(Vector2(0,0), screen_size)

func shoot_rocket():
	var rocket_instance = rocket_scene.instantiate()
	rocket_container.add_child(rocket_instance)
	rocket_instance.global_position = global_position
	rocket_instance.global_position.x += 75

func take_damage():
	emit_signal("took_damage")
	
func die():
	queue_free()
