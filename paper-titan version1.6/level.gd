extends Node2D

var enemy_scene: PackedScene= load("res://enemy.tscn")

func _on_enemytimer_timeout() -> void:
	var enemy = enemy_scene.instantiate()
	$Enemies.add_child(enemy)
