extends CharacterBody2D

var move_speed = 500  # Adjust speed as needed
var immunity_count = 0
var is_immune = false
var lives = 3  # Add lives counter

@onready var immunity_bar = get_node("../UI/ImmunityBar")  # Adjust path based on UI structure

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
	if position.x < 0:
		position.x = screen_size.x
	elif position.x > screen_size.x:
		position.x = 0

	if position.y < 0:
		position.y = screen_size.y
	elif position.y > screen_size.y:
		position.y = 0

func _on_immunity_collected():
	immunity_count += 1

	if immunity_bar:
		immunity_bar.value = immunity_count  # Update UI

	if immunity_count >= 5:
		is_immune = true
		print("Plane is now immune!")

		# Immunity lasts for 10 seconds
		await get_tree().create_timer(10).timeout  
		is_immune = false
		immunity_count = 0  
		immunity_bar.value = immunity_count  # Reset UI

func take_damage():
	if is_immune:
		print("Player is immune! No damage taken.")
		return

	lives -= 1
	print("Lives left:", lives)  # Debugging print

	if lives <= 0:
		print("")
		
