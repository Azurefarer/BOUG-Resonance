extends RigidBody3D

## 157 pixels per second^2 ~~ 9.8 meters per second^2
const GRAVITY = 19.6
## 21 pixels per second ~~ 1.3 meters per second ~~ 3 miles per hour
const WALK_ACC = .5
const WALK_SPEED = 2.6
## 85 pixels per second ~~ 5.3 meters per second ~~ 12 miles per hour
const RUN_ACC = 2.14
const RUN_SPEED = 10.6

var thrust = Vector3(0, -250, 0)
var torque := Vector3(0, 20000, 0)

var iso_trans : Transform3D
var cam_rot_trans : Transform3D

#@onready var state_machine := $CharacterStateMachine as CharacterStateMachine
#@onready var grounded := state_machine._check_if_grounded() as bool
#@onready var can_move := state_machine._check_if_can_move() as bool
#@onready var in_bounds := state_machine._check_if_in_bounds() as bool
#@onready var boug := $Pivot/Model as Sprite2D
#@onready var animation_tree := $AnimationTree as AnimationTree


##################


func _ready():
#	animation_tree.active = true
	
	iso_trans = Transform3D()
	iso_trans.basis.x = Vector3(cos(PI/4), 0 , sin(PI/4))
	iso_trans.basis.z = Vector3(-sin(PI/4), 0 , cos(PI/4))
	

func _integrate_forces(state):
#	if Input.is_action_pressed("ui_up"):
#		state.apply_force(thrust.rotated(Vector3.RIGHT, PI))
#	else:
#		state.apply_force(Vector3())
#	var rotation_direction = 0
#	if Input.is_action_pressed("ui_right"):
#		rotation_direction += 1
#	if Input.is_action_pressed("ui_left"):
#		rotation_direction -= 1
#	state.apply_torque(rotation_direction * torque)
#	state.apply_central_impulse(Vector3(0, -0.98, 0))
#
#	var input_direction : Vector3
#	if Input.is_action_pressed("left"):
#		input_direction.x -= 1
#	if Input.is_action_pressed("right"):
#		input_direction.x += 1
#	if Input.is_action_pressed("up"):
#		input_direction.z -= 1
#	if Input.is_action_pressed("down"):
#		input_direction.z += 1
#	if Input.is_action_pressed("jump"):
#		input_direction.y += 5
#
#	state.apply_impulse(input_direction)
#	state.integrate_forces()
	pass
	

func _physics_process(delta : float):
	apply_central_impulse(Vector3(0, -0.98, 0))

	var input_direction : Vector3
	if Input.is_action_pressed("left"):
		input_direction.x -= 1
	if Input.is_action_pressed("right"):
		input_direction.x += 1
	if Input.is_action_pressed("up"):
		input_direction.z -= 1
	if Input.is_action_pressed("down"):
		input_direction.z += 1
	if Input.is_action_pressed("jump"):
		input_direction.y += 5

	apply_impulse(input_direction * iso_trans)
	pass
	
#	point_stair_sensor()
#	move_and_collide(Vector3(0, 0, 0))
#	update_anim()
#
#
#	move_shadow()


func move_shadow() -> void:
	$Shadow.global_position.y = $ShadowPoint.get_collision_point().y + .1

	
#func update_anim() -> void:
#	var blend_pos = Vector2(linear_velocity.x, linear_velocity.z)
#	animation_tree.set("parameters/Move/blend_position", blend_pos)
#	## Need more sprites
#

func update_facing_direction() -> void:
	## Do not have sprites to implement yet
	pass
	
	
#func point_stair_sensor() -> void:
#	$stairsense.target_position = Vector3.ZERO
#	var target_pos = linear_velocity.normalized() * Vector3(1, 0, 1)
#
#	if target_pos != Vector3.ZERO:
#		$stairsense.enabled = true
#		$stairsense.target_position = target_pos
#		print($stairsense.target_position)
#	else:
#		print(target_pos)
#		$stairsense.enabled = false


	
	###
	# Signals
	###


func _on_node_3d_cam_swivel(direction) -> void:
	cam_rot_trans = Transform3D()
	cam_rot_trans.basis.x = Vector3(cos(direction), 0 , sin(direction))
	cam_rot_trans.basis.z = Vector3(-sin(direction), 0 , cos(direction))


#
#func _on_stairsense_colliding(point : Vector3) -> void:
#	print(point)
#	var local_grid_pos = get_node("../DevMap/GridMap").to_local(point)
#	print(local_grid_pos)
#	var grid_pos = get_node("../DevMap/GridMap").local_to_map(local_grid_pos)
#	print(grid_pos)
#	print(get_node("../DevMap/GridMap").get_cell_item(grid_pos))
#
#
#
#
	
