extends CharacterBody2D

@export var move_speed : float = 200

func handle_input():
	var move_direction = Input.get_vector("left", "right", "up", "down")
	velocity = move_direction * move_speed
	
func _physics_process(delta):
	handle_input()
	move_and_slide()
