extends CharacterBody2D

@export var move_speed : float = 200
@onready var animations = $AnimationPlayer
var is_holding = false
var is_in_area = false
const grabbable_object = preload("res://game/grabbables/grabbable.gd")
var grabbable_in_area
var root_scene
var held_grabbable

func _ready():
	root_scene = get_parent()

func handle_input():
	var move_direction = Input.get_vector("left", "right", "up", "down")
	velocity = move_direction * move_speed
	if Input.is_action_just_pressed("click") and is_in_area and not is_holding:
		grabbable_in_area.reparent($PickableArea)
		held_grabbable = grabbable_in_area
		is_holding = true
		_play_pickup_sound()
	elif Input.is_action_just_pressed("click") and is_holding:
		held_grabbable.reparent(root_scene)
		held_grabbable = null
		is_holding = false
		
func update_animation():
	if velocity.length() == 0:
		animations.stop()
	else:
		animations.play("walk")
	
func _physics_process(delta):
	handle_input()
	move_and_slide()
	update_animation()
	# Rotate towards mouse
	look_at(get_global_mouse_position())

func _on_pickable_area_body_entered(body):
	if body is grabbable_object and not is_in_area and not is_holding:
		grabbable_in_area = body
		is_in_area = true

func _on_pickable_area_body_exited(body):
	if body != held_grabbable:
		return
	if body is grabbable_object:
		grabbable_in_area = null
		is_in_area = false

func _play_pickup_sound():
	$PickUpSound.play(.6)
