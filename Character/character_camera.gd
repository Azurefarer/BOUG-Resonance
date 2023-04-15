extends Camera3D


func _ready() -> void:
	size = 25
	

func _process(delta: float) -> void:
	rotation.x = calc_angle_3d(position)



func calc_angle_3d(local_transform : Vector3) -> float:
	var diag_2d : float
	var angle : float
	var conversion_rad_deg := 180/PI as float
	diag_2d = sqrt(local_transform.x**2 + local_transform.z**2)
	angle = atan(diag_2d / local_transform.y) - PI/2 

	return angle


func _input(event: InputEvent) -> void:
	
	####
	# Orthogonal cam
	####
	
#	if event.is_action_pressed("zoom_in"):
#		size -= 1
#		return
#	if event.is_action_pressed("zoom_out"):
#		size += 1
#		return
#
#	if event is InputEventMouse:
#		if event.is_action_pressed("pan_down") and position.x + position.z < 4000:
#			position.x += 20
#			position.z += 20
#		if event.is_action_pressed("pan_up") and position.x + position.z > 0:
#			position.x -= 20
#			position.z -= 20
	
	####
	# Perspective cam
	####	
	
	if event.is_action_pressed("zoom_in"):
		position = position * .9
		return
	if event.is_action_pressed("zoom_out"):
		position = position * 1.1
		return
		
	if event is InputEventMouse:
		if event.is_action_pressed("pan_down") and position.y > 0:
			position.y -= 5
			position.x -= 1
			position.z -= 1
			if position.y < 0:
				position.y = 0
			print(position)

		if event.is_action_pressed("pan_up") and position.y < 500:
			position.y += 5
			position.x += 1
			position.z += 1


