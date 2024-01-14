extends Node2D

@onready var pause_menu = $PauseMenu
@onready var shop_menu = $ShopMenu
var paused = false


func _process(delta):
	if Input.is_action_just_pressed("pause"):
		pause_game()

func pause_game():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0
		
	paused = !paused


func _on_texture_button_pressed():
	shop_menu.visible = true
