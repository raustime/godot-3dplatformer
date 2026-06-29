extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 12

var xform:Transform3D

func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	# play animation
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		$AnimationPlayer.play("jump")
	elif is_on_floor() and input_dir!=Vector2.ZERO:
		$AnimationPlayer.play("run")
	elif is_on_floor() and input_dir==Vector2.ZERO:
		$AnimationPlayer.play("idle")	
	
	# Camera rotation
	if Input.is_action_just_pressed("cam_left"):
		$CameraController.rotate_y(deg_to_rad(-30))
	if Input.is_action_just_pressed("cam_right"):
		$CameraController.rotate_y(deg_to_rad(30)) 
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY


	var direction = ($CameraController.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if input_dir!=Vector2(0,0):
		$Armature.rotation_degrees.y=$CameraController.rotation_degrees.y-rad_to_deg(input_dir.angle())-90
	#align char with floor
	if is_on_floor():
		$RayCast3D.position = position
		align_with_floor($RayCast3D.get_collision_normal())
	else:
		align_with_floor(Vector3.UP)
		
	global_transform=global_transform.interpolate_with(xform,0.3)
	# move char
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	#CameraControler position
	$CameraController.position=lerp($CameraController.position,position,0.15)
	
	
func align_with_floor(floor_normal):
	xform=global_transform
	xform.basis.y=floor_normal
	xform.basis.x=-xform.basis.z.cross(floor_normal)
	xform.basis=xform.basis.orthonormalized()
		


func _on_fall_zone_body_entered(body: Node3D) -> void:
	get_tree().change_scene_to_file("res://level_1.tscn")
