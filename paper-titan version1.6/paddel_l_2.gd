extends ColorRect

var BALL_SPEED = 200
var ball_vel = Vector2(BALL_SPEED, BALL_SPEED)

var new_player=preload("res://assets/assests for pong/3rd life.jpeg")


func _on_l_2_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "player":
		print("Collided with Player")
		var sprite = body.get_node("plane")
		if sprite:
			sprite.texture = new_player
