extends Sprite3D

@export var DEFAULT_ROTATION_SPEED:=20
var rotation_speed_rad:float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rotation_speed_rad=deg_to_rad(DEFAULT_ROTATION_SPEED)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotate_y(rotation_speed_rad*delta)
