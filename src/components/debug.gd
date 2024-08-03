extends Node

@export var fps: NodePath

var _fps: Label

# Called when the node enters the scene tree for the first time.
func _ready():
	_fps = get_node(fps)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_fps.text = str(Engine.get_frames_per_second())
