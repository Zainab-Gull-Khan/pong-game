extends Control




func _on_quit_button_pressed() -> void:
	get_tree().quit() # Replace with function body.


func _on_play_again_button_pressed() -> void:
	get_tree().change_scene_to_file("res://level.tscn")
