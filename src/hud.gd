extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameState.current_score_changed.connect(update_current_score)
	GameState.highest_score_changed.connect(update_highest_score)


func update_current_score(score):
	$CurrentScoreLabel.text = str(score)

func update_highest_score(score):
	$HighestScoreLabel.text = str(score)
