extends Node

class_name State

@export var can_move := true as bool
@export var grounded := true as bool
@export var in_bounds := true as bool

var character : RigidBody3D
var next_state : State


func state_process(delta : float):
#	if Input.is_anything_pressed() == false:
#		character.velocity = character.velocity * .9999999
		pass


func state_input(event : InputEvent):
	pass



func on_enter():
	pass
	
	
func on_exit():
	pass
