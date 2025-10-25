extends Node

signal flip_ended(is_heads: bool)
signal current_score_changed(score: int)
signal highest_score_changed(score: int)

var current_score: int = 0:
	set(value):
		current_score = value
		current_score_changed.emit(current_score)
var highest_score: int = 0:
	set(value):
		highest_score = value
		highest_score_changed.emit(highest_score)

func _ready() -> void:
	flip_ended.connect(on_flip_ended)

func on_flip_ended(is_heads: bool):
	print("Heads", is_heads)
	if is_heads:
		current_score += 1
	else:
		highest_score = max(current_score, highest_score)
		current_score = 0
