extends Oscillator


func _ready() -> void:
	r_freq = sqrt(n_freq**2 - b**2)

