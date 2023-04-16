extends CharacterBody3D

## 157 pixels per second^2 ~~ 9.8 meters per second^2
const GRAVITY = 19.6
## 21 pixels per second ~~ 1.3 meters per second ~~ 3 miles per hour
const WALK_ACC = .5
const WALK_SPEED = 2.6
## 85 pixels per second ~~ 5.3 meters per second ~~ 12 miles per hour
const RUN_ACC = 2.14
const RUN_SPEED = 10.6

var iso_trans : Transform3D
var cam_rot_trans : Transform3D

@onready var state_machine := $CharacterStateMachine as CharacterStateMachine
@onready var grounded := state_machine._check_if_grounded() as bool
@onready var can_move := state_machine._check_if_can_move() as bool
@onready var in_bounds := state_machine._check_if_in_bounds() as bool
@onready var boug := $Pivot/Model as Sprite2D
@onready var animation_tree := $AnimationTree as AnimationTree


##################


func _ready():
	animation_tree.active = true
	
	velocity = Vector3.ZERO
	iso_trans = Transform3D()
	iso_trans.basis.x = Vector3(cos(PI/4), 0 , sin(PI/4))
	iso_trans.basis.z = Vector3(-sin(PI/4), 0 , cos(PI/4))
	

func _physics_process(delta : float):

	velocity = velocity * iso_trans
	velocity = velocity * cam_rot_trans
	move_and_slide()
	update_anim()
	point_stair_sensor()
	velocity = iso_trans * velocity
	velocity = cam_rot_trans * velocity

	move_shadow()


func move_shadow() -> void:
	$Shadow.global_position.y = $ShadowPoint.get_collision_point().y + .1
	
	
func update_anim() -> void:
	var blend_pos = Vector2(velocity.x, velocity.z)
	animation_tree.set("parameters/Move/blend_position", blend_pos)
	## Need more sprites
	

func update_facing_direction() -> void:
	## Do not have sprites to implement yet
	pass
	
	
func point_stair_sensor() -> void:
	var target_pos = velocity.normalized()
	$Pivot/stairsense.target_position = target_pos * 2
	
	###
	# Signals
	###


func _on_node_3d_cam_swivel(direction) -> void:
	cam_rot_trans = Transform3D()
	cam_rot_trans.basis.x = Vector3(cos(direction), 0 , sin(direction))
	cam_rot_trans.basis.z = Vector3(-sin(direction), 0 , cos(direction))



func _on_stairsense_colliding(point) -> void:
	pass
	
	
	
	
	
