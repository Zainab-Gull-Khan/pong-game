extends Area2D
#immunity bar
@onready var ImmunityBar= $"../CanvasLayer/ImmunityBar"
var healthbar=5
# Ball movement variables
var BALL_SPEED = 200
var ball_vel = Vector2(BALL_SPEED, BALL_SPEED)
# Preload textures for different life stages
var life_3_texture = preload("res://assets/assests for pong/paperclip.jpeg")   # Full life

func ready():
	ImmunityBar.value=healthbar
	
func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		print("Collided with poooo Player")
		healthbar+=1
		ImmunityBar.value=healthbar
		# Get the sprite inside the player node
		var sprite = body.get_node_or_null("plane")
		
		if sprite and global.lives > 0:
			global.lives += 1  # Reduce lives
			print("Lives left:", global.lives)

			

func end_game():
	print("Game Over!")
	get_tree().paused = true  # Pause the game
	





	
