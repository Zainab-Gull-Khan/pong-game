extends Area2D

# Immunity bar
@onready var ImmunityBar = $"../CanvasLayer/ImmunityBar"

var immunity_value = 0  # Starts at 0%

# Life system
@onready var player = $"../player"
var healthbar = 5

# Preload textures for different life stages
var life_3_texture = preload("res://assets/assests for pong/plane.jpeg")   # Full life
var life_2_texture = preload("res://assets/assests for pong/1st life.jpeg") # 2 lives left
var life_1_texture = preload("res://assets/assests for pong/3rd life.jpeg") # 1 life left

func _ready():
	immunity_value = 0
	ImmunityBar.value = immunity_value  # Explicitly set it to 0
	randomize_spawn_position()  # Spawn power-up randomly

func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		print("Collided with Immunity Power-up!")
		
		# Ensure immunity increases by exactly 20% and doesn't exceed 100%
		immunity_value = min(immunity_value + 20, 100)  
		print("Updated Immunity Value:", immunity_value)

		# Update the UI
		ImmunityBar.value = immunity_value

		# Check if immunity reached 100% to gain a life
		if immunity_value == 100:  # Only reset at exactly 100
			print("Immunity reached 100! Resetting now...")
			immunity_value = 0  # Reset immunity bar

			# Increase lives, but cap them at a maximum (e.g., 3)
			if global.lives < 3:
				global.lives += 1  
				print("Life gained! Lives left:", global.lives)
			else:
				print("Max lives reached! No additional life added.")

			# Update the player's texture based on lives
			update_player_texture()

		# Update the UI after potential reset
		ImmunityBar.value = immunity_value  
		ImmunityBar.queue_redraw()  # Force update again

		# Respawn power-up at a new location
		randomize_spawn_position()

func update_player_texture():
	var sprite = player.get_node_or_null("plane")
	if sprite:
		if global.lives == 3:
			sprite.texture = life_3_texture
		elif global.lives == 2:
			sprite.texture = life_2_texture  
		elif global.lives == 1:
			sprite.texture = life_1_texture  

# Function to randomize the power-up's position
func randomize_spawn_position():
	var screen_size = get_viewport_rect().size  # Get screen size
	position.x = randf_range(50, screen_size.x - 50)
	position.y = randf_range(50, screen_size.y - 50)
	print("New Power-up Position:", position)



	





	
