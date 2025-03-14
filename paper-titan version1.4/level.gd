extends Node2D

var enemy_scene = preload("res://enemy.tscn")

func _ready():
	$enemytimer.start()  # Start the timer

func _on_EnemyTimer_timeout():
	var fire = enemy_scene.instantiate()
	var viewport_width = get_viewport().get_visible_rect().size[0]
	fire.position.x = randf() * viewport_width
	fire.position.y = -50  # Start above the screen
	$enemies.add_child(fire)
