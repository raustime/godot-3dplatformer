extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.coins=0
	$HUD.update_coins_display(Global.coins)
	for coin in $Coins.get_children():
		coin.collected.connect(_on_coin_collected)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_coin_collected() -> void:
	Global.coins+=1
	$HUD.update_coins_display(Global.coins)
	
	if Global.coins>=Global.COINS_TO_WIN:
		await get_tree().create_timer(2.0).timeout
		get_tree().change_scene_to_file("res://level_1.tscn")
