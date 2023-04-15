extends Node3D

signal cam_swivel(direction)


var rot := PI/4 as float


func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func _input(event : InputEvent) -> void:
	if event is InputEventKey:
		if event.is_action_pressed("camL"):
			swivel(-PI/6)
		if event.is_action_pressed("camR"):
			swivel(PI/6)
	
	
func swivel(direction : float) -> void:
	rot += direction
	rotate_y(direction)
	emit_signal("cam_swivel", rot - PI/4)
	

