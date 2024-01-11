extends Node2D

@onready var pause_menu = $PauseMenu
@onready var help_menu = $HelpMenu
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
