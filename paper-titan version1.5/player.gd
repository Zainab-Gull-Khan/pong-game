extends CharacterBody2D

var move_speed = 500  # Adjust speed as needed

func _process(delta):
	var direction = Vector2.ZERO
	var screen_size = get_viewport_rect().size

	# Movement input
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_down"):
		direction.y += 1
	if Input.is_action_pressed("ui_up"):
		direction.y -= 1

	# Normalize direction and move the plane
	direction = direction.normalized()
	position += direction * move_speed * delta

	# Wrap around the screen
	if position.x < 0:  # Exits left
		position.x = screen_size.x
	elif position.x > screen_size.x:  # Exits right
		position.x = 0

	if position.y < 0:  # Exits top
		position.y = screen_size.y
	elif position.y > screen_size.y:  # Exits bottom
		position.y = 0
