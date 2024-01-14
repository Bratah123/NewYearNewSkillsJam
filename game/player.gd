extends CharacterBody2D

@export var move_speed : float = 200
@onready var animations = $AnimationPlayer

var is_holding = false
var paused = false
const Grabbable = preload("res://game/grabbables/grabbable.gd")
var grabbable_in_area
var root_scene
var held_grabbable

func _ready():
	root_scene = get_parent()

func _handle_pick_up():
	if Input.is_action_just_pressed("click") and not is_holding:
		# Check if the player is pickable area is hovering over any items
		var items_in_area = $PickableArea.get_overlapping_bodies()
		if len(items_in_area) == 0:
			return
		# Pick up the first VALID thing in the list
		for item in items_in_area:
			if item is Grabbable:
				held_grabbable = item
				break
		if held_grabbable:
			held_grabbable.reparent($PickableArea)
			is_holding = true
			_play_pickup_sound()
			var offset = Vector2(5, -5)
			held_grabbable.position += offset
	elif Input.is_action_just_pressed("click") and is_holding:
		held_grabbable.reparent(root_scene)
		held_grabbable = null
		is_holding = false

func handle_input():
	var move_direction = Input.get_vector("left", "right", "up", "down")
	velocity = move_direction * move_speed
	_handle_pick_up()
		
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

func _play_pickup_sound():
	$PickUpSound.play(.1)

func release_current_held_item():
	if held_grabbable == null:
		return
	held_grabbable.queue_free()
	held_grabbable = null
	is_holding = false
