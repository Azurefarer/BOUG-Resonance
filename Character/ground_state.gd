extends State

class_name GroundState

@export var jump_velocity := -150 as float
@export var air_state : State

# is grounded

func on_enter():
	character.velocity.y = 0


func state_process(delta : float):
	var velocity := character.velocity as Vector3
	var RUN_SPEED := character.RUN_SPEED as float
	var RUN_ACC := character.RUN_ACC as float
	var WALK_SPEED := character.WALK_SPEED as float
	var WALK_ACC := character.WALK_ACC as float
	var last_position := character.last_pos as Vector3
		
	if Input.is_action_just_pressed("jump"):
		jump()
		return
#	if !in_bounds:
#		character.position = last_position
#		character.velocity = Vector2.ZERO
#
#		return
		
#	if Input.is_action_just_released("move_left") or Input.is_action_just_released("move_right"):
#		velocity[0] = 0
#		character.velocity.x = velocity [0]
#
#	if Input.is_action_just_released("move_down") or Input.is_action_just_released("move_up"):
#		velocity[1] = 0
#		character.velocity.y = velocity[1]
#
#
#
#	var input_direction : Vector2 = Input.get_vector(
#			"move_left", "move_right", "move_up", "move_down"
#		)
#	velocity += Vector2(
#			input_direction[0] * 2 * WALK_ACC,
#			input_direction[1] * WALK_ACC
#		)
#	velocity = velocity.clamp(
#			Vector2(-2 * RUN_SPEED, -RUN_SPEED),
#			Vector2(2 * RUN_SPEED, RUN_SPEED)
#		)
#
#	if Input.is_action_pressed("walk"):
#		velocity += Vector2(
#				input_direction[0] * 2 * WALK_ACC, 
#				input_direction[1] * WALK_ACC
#			)
#		velocity = velocity.clamp(
#				Vector2(-2 * WALK_SPEED, -WALK_SPEED),
#				Vector2(2 * WALK_SPEED, WALK_SPEED)
#			)
#
#	character.velocity = velocity


	if Input.is_action_just_released("left") or Input.is_action_just_released("right"):
		velocity[0] = 0
		
	if Input.is_action_just_released("down") or Input.is_action_just_released("up"):
		velocity[2] = 0		
		
	var input_direction : Vector3 = input_dir()
	
	if input_direction != Vector3.ZERO:
		input_direction = input_direction.normalized()
		$"../../Pivot".look_at(last_position + input_direction, Vector3.UP)
	
	velocity += Vector3(
			input_direction[0] * WALK_ACC,
			0,
			input_direction[2] * WALK_ACC
		)
	velocity = velocity.clamp(
			Vector3(-RUN_SPEED, 0, -RUN_SPEED),
			Vector3(RUN_SPEED, 0, RUN_SPEED)
		)
		
	if Input.is_action_pressed("walk"):
		velocity += Vector3(
				input_direction[0] * WALK_ACC,
				0, 
				input_direction[2] * WALK_ACC
			)
		velocity = velocity.clamp(
				Vector3(-WALK_SPEED, 0, -WALK_SPEED),
				Vector3(WALK_SPEED, 0, WALK_SPEED)
			)
			
	character.velocity = velocity


func input_dir() -> Vector3:
	var input_direction : Vector3
	if Input.is_action_pressed("left"):
		input_direction.x -= 1
	if Input.is_action_pressed("right"):
		input_direction.x += 1
	if Input.is_action_pressed("up"):
		input_direction.z -= 1
	if Input.is_action_pressed("down"):
		input_direction.z += 1
		
	return input_direction


func state_input(event : InputEvent):
	pass

func jump():
	character.velocity.y += jump_velocity
	next_state = air_state
	
func on_exit():
	next_state = null


#func _on_terrain_detector_body_exited(body: Node2D) -> void:
#	if body.is_in_group("Ground"):
#		in_bounds = false
#		grounded = false
#
#
#func _on_terrain_detector_body_entered(body: Node2D) -> void:
#	if body.is_in_group("Ground"):
#		in_bounds = true
#		grounded = true

