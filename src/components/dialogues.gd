extends Control
class_name DialogueComponent

signal start()
signal next()

## Groupname lists that using physics
@export var groupname_physic_lists := ['actor', 'camera']
## Signal name when physics is inactive temporary
@export var pyhsics_signal_name_inactive := 'disable_physics'
## Signal name when physics is active again
@export var physics_signal_name_active := 'enable_physics'

@export_category('Scenes')
@export var stories: Array[Variant]
@export var line := 0

@export_category('Panels')
## Nodepath for [Panel] main dialogues scenes
@export var main_panel: NodePath
## Nodepath for [Panel] active character name scenes
@export var active_panel: NodePath
## Nodepath for [Panel] primary character name scenes
@export var primary_panel: NodePath
## Padding for [RichTextLabel] inside the [Panel]
@export var main_padding := Vector2.ZERO
## Padding for [Label] inside the [Panel]
@export var name_padding := Vector2.ZERO

## 
var actor_name: String
var is_active_actor := false

var _main_text: TextPanel
var _active_label: TextPanel
var _primary_label: TextPanel

class TextPanel:
	var _label: Variant
	var _panel: Panel
	
	func _init(node_panel: Panel, padding: Vector2, is_rich_text_label: bool):
		_label = Label.new() if not is_rich_text_label else RichTextLabel.new()
		_label.size = _calculate_padding(padding)
		_label.position = padding
		
		_panel = node_panel
		_panel.call_deferred('add_child', _label)
	
	func _calculate_padding(padding: Vector2) -> Vector2:
		return Vector2(
			_panel.size.x - padding.x * 2,
			_panel.size.y - padding.y * 2
		)
	
	func play(text: String, secs: float = .25) -> void:
		_panel.visible = true
		_label.text = text
		
		if _label.get_class() == 'RichTextLabel':
			_label.visible_ratio = 0
			
			var tween = _panel.get_tree().create_tween()
			tween.tween_property(_label, 'visible_ratio', 1, secs)
	
	func hide():
		_panel.visible = false
		_label.text = ''
	
	func get_panel() -> Panel:
		return _panel


# Called when the node enters the scene tree for the first time.
func _ready():
	_main_text     = TextPanel.new(get_node(main_panel), main_padding, true)
	_active_label  = TextPanel.new(get_node(active_panel), name_padding, false)
	_primary_label = TextPanel.new(get_node(primary_panel), name_padding, false)
	
	next.connect(on_next)
	start.connect(on_start)

# Called when there is an input event is propagates up through the node tree until a node consumes it.
func _input(event):
	if Input.is_action_just_pressed('ui_accept'):
		emit_signal('next')

func storyline() -> void:
	var speed = ProjectSettings.get_setting('framework/components/dialogues/speed')
	speed = .5 if speed == null else speed
	
	if typeof(stories[line]) == TYPE_STRING:
		_primary_label.hide()
		_active_label.hide()
		_main_text.play(stories[line], speed)
	
	elif typeof(stories[line]) == TYPE_DICTIONARY:
		var s : Array = stories[line].keys()
		_main_text.play(stories[line][s[0]], speed)
		
		if stories[line].get('position') == 'active':
			is_active_actor = true
			_primary_label.hide()
			
			if actor_name != s[0]:
				_active_label.play(s[0])
		else:
			is_active_actor = false
			_active_label.hide()
			
			if actor_name != s[0]:
				_primary_label.play(s[0])
		
		actor_name = s[0]

## Signal method when the dialog freshly start
func on_start():
	visible = true
	
	for n in groupname_physic_lists:
		for i in get_tree().get_nodes_in_group(n):
			i.emit_signal('disable_physics')
		
	storyline()

## Signal method when the dialog is on the next line
func on_next():
	if line < len(stories) - 1:
		line += 1
		storyline()
	else:
		visible = false
		
		for n in groupname_physic_lists:
			for i in get_tree().get_nodes_in_group(n):
				i.emit_signal('enable_physics')
		
