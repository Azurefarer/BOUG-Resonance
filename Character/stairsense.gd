extends RayCast3D

signal colliding(point : Vector3)


func _ready() -> void:
	enabled = false

func _physics_process(delta: float) -> void:

	if is_colliding():
		print("collider works")
		emit_signal("colliding", get_collision_point())



