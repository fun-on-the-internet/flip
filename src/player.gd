extends Area2D
signal hit

@export var speed = 400
var screen_size
var touch_velocity = Vector2.ZERO  # Store touch input separately


func _on_body_entered(body: Node2D) -> void:
	hide()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	hide()

func _process(delta: float) -> void:
	var velocity = Vector2.ZERO
	
	# Keyboard/gamepad input
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	
	# Combine with touch input
	velocity += touch_velocity
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = velocity.y > 0

func _input(event):
	if event is InputEventScreenTouch:
		if event.pressed:
			_handle_touch_position(event.position)
		else:
			# Touch released, stop movement
			touch_velocity = Vector2.ZERO
	elif event is InputEventScreenDrag:
		_handle_touch_position(event.position)

func _handle_touch_position(touch_pos: Vector2):
	var screen_center: Vector2i = get_viewport().size / 2
	var touch_offset: Vector2 = touch_pos - Vector2(screen_center)
	var dead_zone = 50
	
	# Check if touch is outside dead zone
	if touch_offset.length() > dead_zone:
		# Use the exact direction from center to touch point
		touch_velocity = touch_offset.normalized()
	else:
		# Inside dead zone, no movement
		touch_velocity = Vector2.ZERO
