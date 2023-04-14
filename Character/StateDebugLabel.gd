extends Label

@export var state_machine : CharacterStateMachine


func _process(delta: float) -> void:
	text = "State : " + state_machine.current_state.name + "\nGrounded : " + (str(state_machine._check_if_grounded()))
