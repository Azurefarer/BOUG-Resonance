extends RayCast3D

signal colliding(point : Object)

func _physics_process(delta: float) -> void:
#	print(position)
#	print(target_position)
	if is_colliding():
		print("collider works")
		emit_signal("colliding", get_collider())
		print(get_collider())


