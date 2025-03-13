extends Sprite2D

var move_speed = 500  # Adjust speed as needed

func _process(delta):
	var direction = Vector2.ZERO
	var screen_size = get_viewport_rect().size
	var ball_size = texture.get_size() * scale  # Ensure ball_size is a Vector2

	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_down"):
		direction.y += 1
	if Input.is_action_pressed("ui_up"):
		direction.y -= 1

	direction = direction.normalized()
	position += direction * move_speed * delta

	# Keep the ball within screen bounds
	position.x = clamp(position.x, ball_size.x / 2, screen_size.x - ball_size.x / 2)
	position.y = clamp(position.y, ball_size.y / 2, screen_size.y - ball_size.y / 2)
