#@tool
extends RemoteTransform3D

var rot := PI/4 as float


func _ready() -> void:
	print(str(InputMap.has_action("camL")))
	print(str(InputMap.has_action("camR")))
	print(transform.basis)
	

func _process(delta: float) -> void:
	calc_angle_3d(position)


func _input(event : InputEvent) -> void:
	if event is InputEventKey:
		if event.is_action_pressed("camL"):
			swivel(-PI/2)
		if event.is_action_pressed("camR"):
			swivel(PI/2)


func calc_angle_3d(local_transform : Vector3) -> float:
	var diag_2d : float
	var angle : float
	var conversion_rad_deg := 180/PI as float
	diag_2d = sqrt(local_transform.x**2 + local_transform.z**2)
	angle = 90 - (atan(diag_2d / local_transform.y) * conversion_rad_deg)
	
	return angle
	
	
func swivel(direction : float) -> void:
	rot += direction
	print(rot*180/PI)
	rotate_y(direction)
	
	var t = transform
	t.origin.x = t.origin.x * sign(sin(rot))
	t.origin.z = t.origin.z * sign(cos(rot))
	transform = t
	print(position)
