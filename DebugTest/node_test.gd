@tool
extends Node

@onready var oscillator := Oscillator.new() as Oscillator


func _ready() -> void:
	oscillator.n_freq = 5
	print(oscillator.n_freq)

