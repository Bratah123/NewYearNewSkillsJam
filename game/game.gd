extends Node2D

@onready var pause_menu = $PauseMenu
@onready var shop_menu = $ShopMenuCanvas
@onready var truck_one = $Truck
@onready var truck_two =$Truck2
@onready var truck_three = $Truck3
@onready var heart_sprite = preload("res://game/lives.tscn")
var lives = []
var paused = false
var x_position = 45


func _ready():
	for index in range(5):
		_add_heart(x_position)
		x_position += 50
		

func _add_heart(x_position):
	var instance = heart_sprite.instantiate()
	for index in range(5):
		instance.position = Vector2(x_position, 40)
		add_child(instance)
		get_parent().add_child(instance)
	lives.append(instance)


func _process(delta):
	if Input.is_action_just_pressed("pause"):
		pause_game()
	if len(lives) == 0:
		get_tree().change_scene_to_file("res://game/main_menu.tscn")
	

func pause_game():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0
		
	paused = !paused


func _on_shop_button_pressed():
	shop_menu.visible = true
	print("shop button pressed")


func _on_truck_delivery_fail():
	var heart = lives.pop_back()
	heart.queue_free()


func _on_truck_2_delivery_fail():
	var heart = lives.pop_back()
	heart.queue_free()


func _on_truck_3_delivery_fail():
	var heart = lives.pop_back()
	heart.queue_free()
