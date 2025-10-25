# camera_switcher.gd
extends Node

@export var cameras: Array[Camera3D] = []
var current_index = 0

func _ready():
	if cameras.size() > 0:
		cameras[0].current = true

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_C:
			switch_camera()

func switch_camera():
	if cameras.size() < 2:
		return
	
	cameras[current_index].current = false
	current_index = (current_index + 1) % cameras.size()
	cameras[current_index].current = true
