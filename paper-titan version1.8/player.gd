extends CharacterBody2D

var move_speed = 500  # Adjust speed as needed
var immunity_count = 0
var is_immune = false

# Reference the immunity bar (ensure correct path)
@onready var immunity_bar = $"../UI/ImmunityBar"  # Adjust path based on UI structure

func _ready():
	# Connect to power-ups in the scene
	for power_up in get_tree().get_nodes_in_group("power_ups"):
		power_up.connect("immunity_collected", _on_immunity_collected)

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

func _on_immunity_collected():
	immunity_count += 1

	# Update immunity bar (if using one)
	if immunity_bar:
		immunity_bar.value = immunity_count  # Assuming it's a ProgressBar

	# Grant immunity after 5 power-ups
	if immunity_count >= 5:
		is_immune = true
		print("Plane is now immune!")

		# Optional: Add a timer to remove immunity after some time
		await get_tree().create_timer(10).timeout  # 10 seconds of immunity
		is_immune = false
		immunity_count = 0  # Reset count
		immunity_bar.value = immunity_count  # Reset the UI bar
