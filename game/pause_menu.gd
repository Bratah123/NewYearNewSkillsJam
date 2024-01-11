extends Control

@onready var game = $"../../"
@onready var help_menu = $CanvasLayer/HelpMenu
@onready var pause_menu = $CanvasLayer/PauseMenu

func _ready():
	help_menu.hide()


func _on_resume_pressed():
	game.pause_game()


func _on_help_pressed():
	pause_menu.visible = false
	help_menu.visible = true


func _on_restart_pressed():
	get_tree().reload_current_scene()
	game.pause_game()


func _on_back_button_pressed():
	pause_menu.visible = true
	help_menu.visible = false
