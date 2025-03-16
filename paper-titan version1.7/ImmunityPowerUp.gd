extends Area2D  

signal immunity_collected  

@export var immunity_type: int = 0  # 0 = Paperclip, 1 = Thumb Pin, 2 = Binder Clip

# Declare the textures outside the function so they are preloaded when the script starts
var textures = [
	preload("res://assets/assests for pong/paperclip.jpeg"),    # 0 = Paperclip
	preload("res://assets/assests for pong/thumbpin.jpeg"),     # 1 = Thumb Pin
	preload("res://assets/assests for pong/binder clip.jpeg")   # 2 = Binder Clip
]

func _ready():
	immunity_type = randi() % 3  # Pick a random type (0, 1, or 2)
	
	# Check if the Sprite2D node exists and the texture is valid
	var sprite = $Sprite2D  # Get reference to Sprite2D node
	if sprite == null:
		print("Error: Sprite2D node not found in the scene!")
		return
	
	# Ensure texture is valid before assigning
	if textures[immunity_type] != null:
		sprite.texture = textures[immunity_type]  # Assign texture based on type
	else:
		print("Error: Texture not loaded.")  # Debugging message if the texture isn't loaded

	# Enable collision detection
	connect("body_entered", _on_body_entered)  

func _on_body_entered(body):
	if body.name == "Player":  
		print("Power-up collected by Player!")
		emit_signal("immunity_collected")  
		queue_free()  # Remove the power-up after collection




	
