extends Area2D

@onready var amount = $TruckSprite/TextBubbleSprite/Amount
@onready var truck_sprite = $TruckSprite
@onready var texture_rect = $TruckSprite/TextBubbleSprite/TextureRect
@onready var deadline_timer = $TruckSprite/DeadlineTimer
@onready var return_timer = $TruckSprite/ReturnTimer
var amount_needed
var rng = RandomNumberGenerator.new()
const assets_folder = "res://assets/"
var crops_png = ["carrot.png", "corn.png", "potato.png", "radish.png", "tomato.png"]
var crop
var tween

# Called when the node enters the scene tree for the first time.
func _ready():
	truck_sprite.position = Vector2(200, 0)
	enter_scene()
	
	
func enter_scene():
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property(truck_sprite, "position", Vector2(0, 0), 5).set_trans(Tween.TRANS_LINEAR)
	generate_amount()
	generate_crop()
	deadline_timer.wait_time = rng.randi_range(3, 10)
	deadline_timer.start()
	
	
func leave_scene():
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property(truck_sprite, "position", Vector2(200, 0), 2).set_trans(Tween.TRANS_LINEAR)
	return_timer.wait_time = rng.randi_range(3, 6)
	return_timer.start()


func generate_amount():
	amount_needed = 1  # rng.randi_range(1, 10)
	if str(amount_needed).length() == 1:
		amount.text = " " + str(amount_needed)
	else:
		amount.text = str(amount_needed)
	
	
func generate_crop():
	print("generates crop")
	var random_index = rng.randi_range(0, crops_png.size() - 1)
	var random_crop = crops_png[random_index]
	crop = random_crop.replace(".png", "")
	texture_rect.texture = load(assets_folder + random_crop)


func _on_deadline_timer_timeout():
	deadline_timer.stop()
	leave_scene()


func _on_return_timer_timeout():
	return_timer.stop()
	enter_scene()
