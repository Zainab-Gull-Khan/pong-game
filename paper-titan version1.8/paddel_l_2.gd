extends ColorRect
@onready var ImmunityBar= $"../CanvasLayer/ImmunityBar"
var healthbar=5
# Ball movement variables
var BALL_SPEED = 200
var ball_vel = Vector2(BALL_SPEED, BALL_SPEED)

# Preload textures for different life stages
var life_3_texture = preload("res://assets/assests for pong/plane.jpeg")   # Full life
var life_2_texture = preload("res://assets/assests for pong/1st life.jpeg") # 2 lives left
var life_1_texture = preload("res://assets/assests for pong/3rd life.jpeg") # 1 life left

func ready():
	ImmunityBar.value=healthbar
	
func _on_l_2_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "player":
		print("Collided with Player")
		
		# Get the sprite inside the player node
		var sprite = body.get_node_or_null("plane")
		healthbar-=1
		ImmunityBar.value=healthbar
		if sprite and global.lives > 0:
			global.lives -= 1  # Reduce lives
			print("Lives left:", global.lives)

			# Update texture based on remaining lives
			if global.lives == 2:
				sprite.texture = life_2_texture
			elif global.lives == 1:
				sprite.texture = life_1_texture
			elif global.lives == 0:
				end_game()

func end_game():
	print("Game Over!")
	get_tree().paused = true  # Pause the game
