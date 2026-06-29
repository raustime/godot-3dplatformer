extends CanvasLayer

func _ready() -> void:
	update_coins_display(0)
	
	
func update_coins_display(value:int):
	$CoinsLabel.text=str(value)
