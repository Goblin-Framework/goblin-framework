extends Node
class_name MainMenu

@export var label_title: NodePath
@export var label_version: NodePath

var _label_title: Label
var _label_version: Label

var _title: String = ProjectSettings.get_setting('application/config/name')
var _version: String = ProjectSettings.get_setting('application/config/version')

# Called when the node enters the scene tree for the first time.
func _ready():
	_label_title = get_node(label_title)
	_label_version = get_node(label_version)
	
	_label_title.text = _title
	_label_version.text = _version
