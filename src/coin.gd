extends RigidBody3D

var is_flipping = false

func _ready():
	pass
	# freeze = true  # Start frozen

func _input(event):
	# Detect any key press or mouse click
	if not event.pressed:
		return

	if (event is InputEventKey and event.keycode == KEY_SPACE) or event is InputEventScreenTouch:
		flip_coin()

func flip_coin():
	position.y = 0  # Reset to ground level
	position.x = 0  # Reset to ground level
	position.z = 0  # Reset to ground level
	
	# Apply random spin
	var torque = Vector3(
		randf_range(-4, -6),0,0
		# randf_range(20, 30),
		# randf_range(-15, 15)
	)
	
	# Optional: slight upward push
	apply_central_impulse(Vector3(0, 30, 0))
	await get_tree().create_timer(0.1).timeout
	apply_torque_impulse(torque)

	await get_tree().create_timer(0.8).timeout
	is_flipping = true

func _process(delta):
	if is_flipping:
		# Check if coin has stopped moving
		if angular_velocity.length() < 0.1 and linear_velocity.length() < 0.1:
			# Check which way the coin's "up" face is pointing
			var coin_up = transform.basis.y  # Coin's local Y axis
			var dot_product = coin_up.dot(Vector3.UP)  # Compare to world up
			
			if dot_product > 0.8:
				# Top face is pointing up = Heads
				finish_flip(true)
			elif dot_product < -0.8:
				# Bottom face is pointing up = Tails
				finish_flip(false)
			# If between, still wobbling - keep waiting

func finish_flip(is_heads: bool):
	is_flipping = false
	GameState.flip_ended.emit(is_heads)

