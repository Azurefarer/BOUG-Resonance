extends Node

class_name CharacterStateMachine

@export var character : CharacterBody3D
@export var current_state : State

var states : Array[State]

func _ready():
	for child in get_children():
		if child is State:
			states.append(child)
			
			# Set the states up with what they need to function
			child.character = character
		else:
			push_warning("Child " + child.name + " is not a State for CharacterStateMachine")
			
			
func _physics_process(delta: float) -> void:
	if current_state.next_state != null:
		switch_states(current_state.next_state)
		
	current_state.state_process(delta)
		
		
func switch_states(new_state : State):
	if current_state != null:
		current_state.on_exit()
		current_state.next_state = null
		
	current_state = new_state
	
	current_state.on_enter()
	
	
func get_state() -> State:
	return current_state
	
	
func _input(event : InputEvent):
	current_state.state_input(event)
	
			

func _check_if_can_move():
	return current_state.can_move
	
func _check_if_grounded():
	return current_state.grounded
	
func _check_if_in_bounds():
	return current_state.in_bounds
	


#func _on_out_of_bounds_went_out_of_bounds() -> void:
#	current_state = states[3]
#
#
#func _on_in_bounds_went_in_bounds() -> void:
#	current_state = states[4]
