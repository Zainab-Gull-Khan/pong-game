#
#extends Area2D
#@onready var plane_burns: AudioStreamPlayer2D = $"../plane_burns"
#
#var is_alive: bool = true  # Track fire state
#var life_end_texture = preload("res://assets/assests for pong/dead plane.jpeg")  # Preload texture
#
#func _on_body_entered(body):
	#
	#if body.name == "player":  # Check if the colliding body is the plane
		#print("Plane collided with fire!")
		#plane_dies(body)  # Call function to handle plane death
		#end_game()  # Call function to end the game
	#
#
#func plane_dies(body):
	## Handle the plane's death (e.g., change its texture or remove it)
	#if body.has_node("Sprite"): 
		#plane_burns.play() # Ensure the plane has a Sprite child
		#var sprite = body.get_node("Sprite")  # Get the Sprite node
		#sprite.texture = life_end_texture  # Change the texture to indicate the plane is "dead"
	#print("Plane is now dead!")
#
#func end_game():
	## Logic to end the game
	#print("Game Over!")
	#get_tree().change_scene_to_file("res://game_over_screen.tscn")
extends Area2D

@onready var plane_burns: AudioStreamPlayer2D = $"../plane_burns"

var is_alive: bool = true  # Track fire state
var life_end_texture = preload("res://assets/assests for pong/dead plane.jpeg")  # Preload texture

func _on_body_entered(body):
	if body.name == "player":  # Check if the colliding body is the plane
		plane_burns.play()
		print("Plane collided with fire!")
		plane_dies(body)  # Handle plane death
		wait_and_end_game()  # Wait before transitioning to the end game screen

func plane_dies(body):
	# Handle the plane's death (e.g., change its texture or play sound)
	if body.has_node("plane"):
		plane_burns.play()  # Play collision sound
		var sprite = body.get_node_or_null("plane")  # Get the Sprite node
		sprite.texture = life_end_texture  # Change the texture to indicate the plane is "dead"
		print("Plane is now dead!")

func wait_and_end_game() -> void:
	# Add a delay before ending the game
	await get_tree().create_timer(1.5).timeout  # Wait for 2 seconds
	end_game()  # Transition to the Game Over screen

func end_game():
	# Logic to end the game
	print("Game Over!")
	get_tree().change_scene_to_file("res://game_over_screen.tscn")
