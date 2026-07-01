extends AnimatableBody3D
var start_position:Vector3
@export var target_positon:=Vector3.ZERO
@export var move_time:float=2.0
@export var move_pause:float=0.7


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_position=position
	move()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func move():
	var move_twin:=create_tween()
	move_twin.set_loops(0)
	move_twin.tween_property(self,"position",target_positon,move_time,).set_delay(move_pause).set_trans(Tween.TRANS_CUBIC)
	move_twin.tween_property(self,"position",start_position,move_time,).set_delay(move_pause).set_trans(Tween.TRANS_CUBIC)
