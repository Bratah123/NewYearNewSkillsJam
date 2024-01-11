extends Sprite2D

const Grabbable = preload("res://game/grabbables/grabbable.gd")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print($PlantingArea.get_overlapping_areas())


func _on_area_2d_body_entered(body):
	print(body, "has entered the field")
	if body is Grabbable:
		print("Grabbable has entered the area")
