extends State

class_name AirState

@export var ground_state : State


##################################


func on_enter():
	pass	
	
func on_exit():
	next_state = null


func state_process(delta : float):
	var velocity := character.velocity as Vector3
	var RUN_SPEED := character.RUN_SPEED as int
	var RUN_ACC := character.RUN_ACC as int
	var WALK_SPEED := character.WALK_SPEED as int
	var WALK_ACC := character.WALK_ACC as int
	var pos := character.position as Vector3
	
	velocity[1] -= character.GRAVITY/32
		
#	if Input.is_action_just_released("left") or Input.is_action_just_released("right"):
#		velocity[0] = 0
#
#	if Input.is_action_just_released("down") or Input.is_action_just_released("up"):
#		velocity[2] = 0
#
	var input_direction : Vector3 = input_dir()
	
	if input_direction != Vector3.ZERO:
		input_direction = input_direction.normalized()
		$"../../Pivot".look_at(pos + input_direction, Vector3.UP)
		
	if input_direction.dot(Vector3.RIGHT) == 1 or input_direction.dot(Vector3.LEFT) == 1 or input_direction == Vector3.ZERO:
		velocity[2] = velocity[2] * .00001
		
	if input_direction.dot(Vector3.FORWARD) == 1 or input_direction.dot(Vector3.BACK) == 1 or input_direction == Vector3.ZERO:
		velocity[0] = velocity[0] * .00001
	
	velocity += Vector3(
			input_direction[0] * RUN_ACC,
			0,
			input_direction[2] * RUN_ACC
		)
	velocity = velocity.clamp(
			Vector3(-RUN_SPEED, -100, -RUN_SPEED),
			Vector3(RUN_SPEED, 100, RUN_SPEED)
		)
		
	if Input.is_action_pressed("walk"):
		velocity += Vector3(
				input_direction[0] * WALK_ACC,
				0,
				input_direction[2] * WALK_ACC
			)
		velocity = velocity.clamp(
				Vector3(-2 * WALK_SPEED, -100, -WALK_SPEED),
				Vector3(2 * WALK_SPEED, 100, WALK_SPEED)
			)
		
	if character.is_on_floor():
		land()
	
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
	
	
# smthing that tells me I've landed
# should have to do with (highest_current_elevation) and time it SHOULD take to become grounded again
# playing with time instead of collisions feels like cheating but it will work for now

# it will switch states back to grounded
# take framework for switching states from gorund module
	
	
func land():
	next_state = ground_state


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
#
#

