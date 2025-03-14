extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() :
	var random := RandomNumberGenerator.new()
	#start 
	var width= get_viewport_rect().size[0]
	var randomx=random.randi_range(0,width)
	var randomy=random.randi_range(-150, -50)
	position =Vector2(randomx,randomy)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) :
	position +=Vector2(0,1.0)*400*delta
	if position.y > get_viewport_rect().size[0]:
		queue_free()

func _on_body_entered(body) :
	print("body entered") # Replace with function body.
	print(body)
