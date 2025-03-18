extends Area2D

var speed: int
var direction_x: float

# Keep track of enemies
const MAX_ENEMIES = 4
static var enemy_count = 0  # Use static so all enemies share this variable

func _ready():
	if enemy_count >= MAX_ENEMIES:
		queue_free()  # Prevent spawning more than 4
		return

	enemy_count += 1  # Increase count when spawned

	# Get viewport size
	var viewport_size = get_viewport().get_visible_rect().size
	var width = viewport_size.x
	var height = viewport_size.y
	var random = RandomNumberGenerator.new()

	# Spawn in the **TOP-LEFT REGION ONLY**
	var random_x = random.randi_range(50, width / 2)  # Between 50 and half the width
	var random_y = random.randi_range(50, height / 3)  # Between 50 and one-third the height

	position = Vector2(random_x, random_y)

	# Set speed and movement direction
	speed = random.randi_range(200, 300)
	direction_x = random.randf_range(-1, 1)

func _process(delta):
	# Move enemies downward
	position.y += speed * delta

	var viewport_size = get_viewport().get_visible_rect().size
	if position.y > viewport_size.y + 50:  # Remove when off-screen
		queue_free()
		enemy_count -= 1  # Decrease count when removed
