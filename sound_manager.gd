extends Control

func _ready() -> void:
	$MenuMusic.play()
	
func play_enemy_sound():
	$SoundEnemy.play()

func play_coin_sound():
	$SoundCoin.play()
	
func play_fall_sound():
	$SoundFall.play()
	
func play_button_sound():
	$SoundButton.play()
	
func play_menu_music():
	$MenuMusic.play()
	
func stop_menu_music():
	$MenuMusic.stop()

func play_level_music():
	$LevelMusic.play()
	
func stop_level_music():
	$LevelMusic.stop()
