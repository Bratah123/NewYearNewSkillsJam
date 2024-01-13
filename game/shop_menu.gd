extends CanvasLayer

@onready var game = $"../"
@onready var shop_menu = $ShopMenu
var seed_bag = preload("res://game/grabbables/carrot_seed.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_carrot_pressed():
	var instance = seed_bag.instantiate()
	_set_position(instance)
	add_child(instance)

func _on_radish_pressed():
	var instance = seed_bag.instantiate()
	_set_position(instance)
	add_child(instance)

func _on_tomato_pressed():
	var instance = seed_bag.instantiate()
	_set_position(instance)
	add_child(instance)

func _on_potato_pressed():
	var instance = seed_bag.instantiate()
	_set_position(instance)
	add_child(instance)

func _on_corn_pressed():
	var instance = seed_bag.instantiate()
	_set_position(instance)
	add_child(instance)

func _on_texture_button_pressed():
	shop_menu.visible = false

func _set_position(seed_bag):
	seed_bag.position = Vector2(90, 610)
