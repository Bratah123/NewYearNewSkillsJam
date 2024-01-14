extends CanvasLayer

@onready var game = $"../"
@onready var shop_menu = $ShopMenu
var carrot_bag = preload("res://game/grabbables/carrot_seed.tscn")
var radish_bag = preload("res://game/grabbables/radish_seed.tscn")
var tomato_bag = preload("res://game/grabbables/tomato_seed.tscn")
var potato_bag = preload("res://game/grabbables/potato_seed.tscn")
var corn_bag = preload("res://game/grabbables/corn_seed.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_carrot_pressed():
	var instance = carrot_bag.instantiate()
	_set_position(instance)
	add_child(instance)

func _on_radish_pressed():
	var instance = radish_bag.instantiate()
	_set_position(instance)
	add_child(instance)

func _on_tomato_pressed():
	var instance = tomato_bag.instantiate()
	_set_position(instance)
	add_child(instance)

func _on_potato_pressed():
	var instance = potato_bag.instantiate()
	_set_position(instance)
	add_child(instance)

func _on_corn_pressed():
	var instance = corn_bag.instantiate()
	_set_position(instance)
	add_child(instance)

func _on_texture_button_pressed():
	shop_menu.visible = false

func _set_position(seed_bag):
	seed_bag.position = Vector2(90, 610)
