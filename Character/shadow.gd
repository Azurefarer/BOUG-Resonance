extends Sprite3D

var distance : float


func _process(delta: float) -> void:
	distance = get_parent().global_position.y - global_position.y
	
	modulate.a = 1 - distance/9
