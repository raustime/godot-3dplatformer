extends Control


func _on_button_pressed() -> void:
	SoundManager.play_button_sound()
	get_tree().change_scene_to_file("res://level_1.tscn")


func _on_button_exit_pressed() -> void:
	SoundManager.play_button_sound()
	get_tree().quit()
