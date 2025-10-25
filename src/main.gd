extends Node

var score


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func game_over() -> void:
	pass
	# $ScoreTimer.stop()
	# $MobTimer.stop()
	# $HUD.show_game_over()
	# $Music.stop()
	# $Death.play()

func new_game():
	score = 0
	# $Player.start($StartPosition.position)
	# $StartTimer.start()
	# $Music.play()

	# $HUD.update_score(score)
	# $HUD.show_message("Get Ready")
	# get_tree().call_group("mobs", "queue_free")

func _on_start_timer_timeout() -> void:
	pass
