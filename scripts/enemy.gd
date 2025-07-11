extends Area2D

signal died

@export var speed = 300

func _physics_process(delta):
	global_position.x -= speed * delta
	
func die():
	queue_free()
	emit_signal("died")
	
func _on_body_entered(body):
	body.take_damage()
	die()
