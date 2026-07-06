extends Control

func _ready() -> void:
	SoundManager.stop_level_music()
	SoundManager.play_menu_music()
	
func _on_button_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://menu_title.tscn")
