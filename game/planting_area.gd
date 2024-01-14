extends Sprite2D

@onready var plant_growing_sprite = $PlantGrowingSprite
var planted = false
var plant_tween
const Grabbable = preload("res://game/grabbables/grabbable.gd")
const crops_name = ["carrot.png", "corn.png", "potato.png", "radish.png", "tomato.png"]
const plant_growth_time = 5 # In seconds
const assets_folder = "res://assets/"
const carrot_bag = preload("res://game/grabbables/carrot.tscn")
const corn_bag = preload("res://game/grabbables/corn.tscn")
const potato_bag = preload("res://game/grabbables/potato.tscn")
const radish_bag = preload("res://game/grabbables/radish.tscn")
const tomato_bag = preload("res://game/grabbables/tomato.tscn")
const seed_objects = [carrot_bag, corn_bag, potato_bag, radish_bag, tomato_bag]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _start_plant_growth(seed_type):
	plant_tween = create_tween()
	plant_tween.tween_property(plant_growing_sprite, "scale", Vector2(1.5, 1.5), plant_growth_time)
	plant_tween.set_trans(Tween.TRANS_LINEAR)
	plant_tween.tween_callback(_reset_plant_area.bind(seed_type))
	
	
func _assign_sprite_from_seed_type(seed_type):
	var crop_sprite = crops_name[seed_type-1] # Seed type starts from 1
	plant_growing_sprite.texture = load(assets_folder + crop_sprite)
	_start_plant_growth(seed_type)


func _reset_plant_area(seed_type):
	plant_tween.kill()
	plant_growing_sprite.scale = Vector2(0, 0)
	plant_growing_sprite.texture = null
	planted = false
	# Spawn in a real vegetable in it's place
	var vegetable_to_spawn = seed_objects[seed_type-1]
	var vegetable_object = vegetable_to_spawn.instantiate()
	vegetable_object.position = $".".position
	vegetable_object.scale = Vector2(1.5, 1.5)
	vegetable_object.seed_type = seed_type
	get_parent().add_child(vegetable_object)


"""
	Check if an area enters the planting area
	For some odd reason, the PlantingArea cannot detect static bodies
"""
func _on_planting_area_area_entered(area):
	var parent_node = area.get_parent()
	# If a grabbable is within our range, plant the plant
	if parent_node is Grabbable and not planted:
		print("Grabbable with type: ", parent_node.seed_type, " has been planted")
		if not parent_node.plantable or parent_node.planted:
			return
		planted = true
		parent_node.planted = true
		# Grab the player holding this item
		var player = parent_node.get_parent().get_parent()
		player.release_current_held_item()
		_assign_sprite_from_seed_type(parent_node.seed_type)
		_play_planting_sound()
		
		
func _play_planting_sound():
	$PlantingCropAudio.play(0.64)
