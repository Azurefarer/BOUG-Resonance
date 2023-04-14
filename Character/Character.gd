extends CharacterBody3D

## 157 pixels per second^2 ~~ 9.8 meters per second^2
const GRAVITY = 9.8
## 21 pixels per second ~~ 1.3 meters per second ~~ 3 miles per hour
const WALK_ACC = .5
const WALK_SPEED = 2.6
## 85 pixels per second ~~ 5.3 meters per second ~~ 12 miles per hour
const RUN_ACC = 2.14
const RUN_SPEED = 10.6

var ground_pos : Vector3
var last_pos : Vector3
var elevation : int
var isometric_transformation : Transform3D

@onready var state_machine := $CharacterStateMachine as CharacterStateMachine
@onready var grounded := state_machine._check_if_grounded() as bool
@onready var can_move := state_machine._check_if_can_move() as bool
@onready var in_bounds := state_machine._check_if_in_bounds() as bool


##################


func _ready():
	last_pos = position
	elevation = 0
	velocity = Vector3.ZERO
	isometric_transformation = Transform3D()
	isometric_transformation.basis.x = Vector3(cos(PI/4), 0 , sin(PI/4))
	isometric_transformation.basis.z = Vector3(-sin(PI/4), 0 , cos(PI/4))


func _physics_process(delta : float):
	grounded = state_machine._check_if_grounded()
	can_move = state_machine._check_if_can_move()
	in_bounds = state_machine._check_if_in_bounds()
	
	velocity = velocity * isometric_transformation
	move_and_slide()
	velocity = isometric_transformation * velocity
	
	move_shadow()


func move_shadow() -> void:
	$Shadow.global_position.y = $ShadowPoint.get_collision_point().y + .1
#	print($ShadowPoint.get_collision_point().y)

#func get_position() -> Vector3:
#	return position


#func _input(event : InputEvent):
#
#	if event is InputEventKey and event.pressed:
#		var top_right_text := $GUI/RichTextLabel2 as RichTextLabel
#		top_right_text.clear()
#		top_right_text.push_color("BLACK")
#		(top_right_text).append_text("Inputs: " 
#				+ event.as_text())
#		top_right_text.pop()
#
#	elif Input.is_anything_pressed() == false:
#		var top_right_text := $GUI/RichTextLabel2 as RichTextLabel
#		(top_right_text).set_text("Inputs:")
#
#
#func get_input():
#	pass
#	var input_direction : Vector3 = Input.get_vector(
#		"move_left", "move_right", "move_up", "move_down"
#	)		
#	velocity = Vector3(input_direction[0] * 2 * RUN_SPEED,
#			input_direction[1] * RUN_SPEED)
#	if Input.is_action_pressed("walk"):
#		velocity = Vector3(input_direction[0] * 2 * WALK_SPEED, input_direction[1] * WALK_SPEED)

#	if Input.is_action_just_pressed("jump"):
#		velocity.y = -1500
#		print(str(velocity.y))


# works on the boundaries
#func _on_area_2d_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
#	if body.is_in_group("Ground"):
#		grounded = true

#
#func _on_terrain_detector_terrain_entered(terrain_type : int) -> void:
#	if terrain_type > 0:
#		grounded = true


#func _on_terrain_detector_elevated_to(new_elevation) -> void:
#	var delta := new_elevation - elevation as int
#	elevation = new_elevation
#	position = position - (delta * Vector2(0, 4))

#
#func _on_terrain_detector_body_entered(body: Node2D) -> void:
#	if body.is_in_group("Ground"):
#		grounded = true
#

#func _on_terrain_detector_body_exited(body: Node2D) -> void:
#	if body.is_in_group("Ground"):
#		grounded = false
#		print("levitating")


##########################################################################
##########################################################################
##########################################################################
##########################################################################

#
#extends CharacterBody3D
#
#@export var speed := 14 as int
#
#@export var fall_acceleration := 10 as int
#
#
#var target_velocity := Vector3.ZERO
#
#
#func _ready() -> void:
#	pass
#
#
#func _physics_process(delta: float) -> void:
#
#	var direction = Vector3.ZERO
#
#
#
#	if Input.is_action_pressed("ui_left", true):
#		direction.x -= 1
#	if Input.is_action_pressed("ui_right", true):
#		direction.x += 1
#	if Input.is_action_pressed("ui_up", true):
#		direction.z -= 1
#	if Input.is_action_pressed("ui_down", true):
#		direction.z += 1
#
#	if direction != Vector3.ZERO:
#		direction = direction.normalized()
#		$Pivot.look_at(position + direction, Vector3.UP)
#
#	# ground vel
#	target_velocity.x = direction.x * speed
#	target_velocity.z = direction.z * speed
#
#	# vert vel
#	if not is_on_floor():
#		target_velocity.y = target_velocity.y - (fall_acceleration * delta)
#
#	velocity = target_velocity	
#
#	print(str(position))
#	move_and_slide()
#
#	###################
#	# only works in 2d //// returns a Vector2
##	var input_direction := Input.get_vector(
##			"move_lest", "move_right", "move_up", "move_down"
##	)
#	################
#	# use is_action() or is_action_pressed() and set exactmatch : bool = true
#func _input(event : InputEvent) -> void:
#	pass
