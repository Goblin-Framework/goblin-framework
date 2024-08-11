extends Control
class_name DialogueComponent

@export var first_char_panel: NodePath
@export var second_char_panel: NodePath
@export var conversation_panel: NodePath
@export var conversation_dict: Dictionary

var _fcp: Panel
var _scp: Panel
var _cvp: Panel

# Called when the node enters the scene tree for the first time.
func _ready():
	_fcp = get_node(first_char_panel)
	_scp = get_node(second_char_panel)
	_cvp = get_node(conversation_panel)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
