extends Node

var power_up_scene = preload("res://power_up.tscn")  # Adjust the path
var active_power_up = null  # Track active power-up
@export var spawn_area : Vector2 = Vector2(572, 362)  # Define spawn bounds

func _ready():
	# Start a timer for periodic spawning
	var timer = Timer.new()
	timer.wait_time = randf_range(5, 10)  # Random spawn every 5-10 seconds
	timer.autostart = true
	timer.one_shot = false
	timer.connect("timeout", spawn_power_up)
	add_child(timer)

func spawn_power_up():
	if active_power_up == null:  # Ensure only one exists at a time
		active_power_up = power_up_scene.instantiate()
		add_child(active_power_up)

		# Set random position inside the spawn area
		active_power_up.position = Vector2(randf_range(0, spawn_area.x), randf_range(0, spawn_area.y))

		# When collected, remove reference so a new one can spawn
		active_power_up.connect("immunity_collected", _on_power_up_collected)

func _on_power_up_collected():
	active_power_up.queue_free()  # Remove the collected power-up
	active_power_up = null  # Allow spawning a new one
