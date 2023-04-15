extends Label


func _process(delta: float) -> void:
	text = str(get_parent().state_machine.current_state.name)
