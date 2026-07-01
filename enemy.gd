extends CharacterBody3D


var speed:float = 2.0

@export var direction:=Vector3(-1,0,0)
@export var turns_around_at_edges:bool=true
var is_turning:bool=false


func _physics_process(delta: float) -> void:
	velocity.x=speed*direction.x
	velocity.z=speed*direction.z
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	move_and_slide()

	if is_on_wall() and not is_turning:
		turn_around()
		
	if not $RayCast3D.is_colliding() and is_on_floor() and not is_turning and turns_around_at_edges:
		turn_around()
		
func turn_around():
	is_turning=true
	var tmp_dir:=direction
	direction=Vector3.ZERO
	var turn_tween=create_tween()
	turn_tween.tween_property(self,"rotation_degrees",Vector3(0,180,0),0.6).as_relative()
	await get_tree().create_timer(0.6).timeout
	direction.x=tmp_dir.x*-1
	direction.z=tmp_dir.z*-1
	is_turning=false

	
	


func _on_side_checker_body_entered(_body: Node3D) -> void:
	get_tree().call_deferred("change_scene_to_file", "res://level_1.tscn")


func _on_top_checker_body_entered(body: Node3D) -> void:
	$AnimationPlayer.play("squash")
	body.bounce()
	disable_collission_checkers()
	speed=0
	await get_tree().create_timer(1.0).timeout
	queue_free()
	
func disable_collission_checkers():
	$SideChecker.set_collision_mask_value(1,false)
	$TopChecker.set_collision_mask_value(1,false)
