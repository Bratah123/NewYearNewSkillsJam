extends Sprite2D

var planted = false
const Grabbable = preload("res://game/grabbables/grabbable.gd")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

"""
	Check if an area enters the planting area
	For some odd reason, the PlantingArea cannot detect static bodies
"""
func _on_planting_area_area_entered(area):
	var parent_node = area.get_parent()
	# If a grabbable is within our range, plant the plant
	if parent_node is Grabbable and not planted:
		print("Grabbable has entered the zone")
		planted = true
		# Grab the player holding this item
		var player = parent_node.get_parent().get_parent()
		player.release_current_held_item()
		_play_planting_sound()
		
func _play_planting_sound():
	$PlantingCropAudio.play(0.64)
