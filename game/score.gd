extends CanvasLayer

@onready var score_count = $ScoreCount
var score = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	score_count.text = "Score:" + str(score)

func increase_score():
	score += 10
	_update_score()
	
func decrease_score(value):
	score -= value
	_update_score()
	
func _update_score():
	score_count.text = "Score:" + str(score)
