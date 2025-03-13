extends Node2D

var move_speed = 200  # Adjust speed as needed
var move_direction = Vector2.ZERO
var screen_size

func _ready():
	screen_size = get_viewport_rect().size
	randomize_fire()

func _process(delta):
	position += move_direction * move_speed * delta

	# Keep the fire within bounds
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	position.x = clamp(position.x, 0, screen_size.x - 1)
	position.y = clamp(position.y, 0, screen_size.y - 1)

func randomize_fire():
	# Get all child fire variations
	var fire_variants = get_children()
	
	# Hide all fires
	for fire in fire_variants:
		fire.visible = false
	
	# Randomly show one
	var random_fire = fire_variants[randi() % fire_variants.size()]
	random_fire.visible = true

	# Set a new random direction for movement
	move_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()

	# Set another random appearance time
	var random_time = randf_range(1, 3)  # Change every 1 to 3 seconds
	get_tree().create_timer(random_time).timeout.connect(randomize_fire)
	
	
