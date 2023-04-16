extends Node3D

signal physicsProcess

@export var direction = 0
@export var camDirection = 0
@export var relativeDirection = 0
@export var finalDirection = 0
@export var playing = "none"
var offset = 0
var lastCam = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	direction = rotationToDirection(get_parent().get_node("Pivot").rotation.y)
	#camDirection = rotationToDirection(get_parent().get_node("CamSwivel").rotation.y)
	relativeDirection = posmod(direction-offset,8)
	if get_parent().velocity.length()>Vector3(.1,.1,.1).length():
		offset = 0
	setAnimation()
func rotationToDirection(rot):
	var newDirection = posmod(floori(rot/(2*PI)*8+4.5),8)
	return newDirection
	print(newDirection)
	print(rot)
	
func _input(event):
	if event.is_action_pressed("camR"):
		offset+=1
	if event.is_action_pressed("camL"):
		offset-=1
	
func setAnimation():
	if playing!="idle":
		playing = "idle"
		get_parent().get_node("AnimationPlayer").play("idle")
		get_parent().get_node("AnimationPlayer").stop()
	get_parent().get_node("AnimationPlayer").seek(relativeDirection*.1,true)
