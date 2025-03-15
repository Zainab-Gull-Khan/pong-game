extends Area2D

var speed: int
var directon_x:float
# Called when the node enters the scene tree for the first time.
func _ready() :
	var random :=RandomNumberGenerator.new()
	var width=get_viewport().get_visible_rect().size[0]
	#var width = 1152 # hardcoding it as the uper code line is generating fires outside of the view screen
	var random_x=random.randi_range(0, width)
	var random_y=random.randi_range(-150,-50)
	position = Vector2(random_x,random_y)
	
	#speed , direction
	speed = random.randi_range(200,300)
	directon_x= random.randf_range(-1,1)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position+=Vector2(directon_x,1)*speed*delta
	


func _on_body_entered(body: Node2D) -> void:
	print("body entered") # Replace with function body.
	print (body)
