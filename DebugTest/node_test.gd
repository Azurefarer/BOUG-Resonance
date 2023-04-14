@tool
extends Node

# safe typing
var a := Vector2(3, 4)

var b : Vector2

var below_os : SceneTree
var c : int

func _ready():
	c = 33 >> 1
	print(c)


func _process(delta):
	pass
