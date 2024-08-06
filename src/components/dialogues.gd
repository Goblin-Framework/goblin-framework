extends Control
class_name DialogueComponent

signal start()
signal next()

@export var dialogues_pause_physics_groupnames := ['actor', 'camera']
@export_category('Scenes')
@export var stories: Array[Variant]
@export var line := 0

@export_category('Main Panel')
## Nodepath for [Panel] main dialogues scenes
@export var main_panel: NodePath
## Padding for [RichTextLabel] inside the [Panel]
@export var main_padding := Vector2.ZERO

@export_category('Active Panel')
## Nodepath for [Panel] active character name scenes
@export var active_panel: NodePath
## Padding for [Label] inside the [Panel]
@export var active_padding := Vector2.ZERO

@export_category('Primary Panel')
## Nodepath for [Panel] primary character name scenes
@export var primary_panel: NodePath
## Padding for [Label] inside the [Panel]
@export var primary_padding := Vector2.ZERO

var current_name: String
var is_active := false

var main_text: TextPanel
var active_label: TextPanel
var primary_label: TextPanel

class TextPanel:
	var _label: Variant
	var _panel: Panel
	
	func _init(node_panel: Panel, padding: Vector2, is_rich_text_label: bool):
		_panel = node_panel
		_label = Label.new() if not is_rich_text_label else RichTextLabel.new()
		_label.size = _calculate_padding(padding)
		_label.position = padding
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

func _ready():
	_initiate_main_text()

func _input(event):
	if Input.is_action_just_pressed('ui_accept'):
		emit_signal('next')

func _initiate_main_text() -> void:
	main_text     = TextPanel.new(get_node(main_panel), main_padding, true)
	active_label  = TextPanel.new(get_node(active_panel), active_padding, false)
	primary_label = TextPanel.new(get_node(primary_panel), primary_padding, false)
	
	next.connect(on_next)
	start.connect(on_start)

func run_storyline() -> void:
	var speed = ProjectSettings.get_setting('framework/components/dialogues/speed')
	speed = .5 if speed == null else speed
	
	if typeof(stories[line]) == TYPE_STRING:
		primary_label.hide()
		active_label.hide()
		main_text.play(stories[line], speed)
	
	elif typeof(stories[line]) == TYPE_DICTIONARY:
		var s : Array = stories[line].keys()
		main_text.play(stories[line][s[0]], speed)
		
		if stories[line].get('position') == 'active':
			is_active = true
			primary_label.hide()
			
			if current_name != s[0]:
				active_label.play(s[0])
		else:
			is_active = false
			active_label.hide()
			
			if current_name != s[0]:
				primary_label.play(s[0])
		
		current_name = s[0]

## Signal method when the dialog freshly start
func on_start():
	visible = true
	
	for n in dialogues_pause_physics_groupnames:
		for i in get_tree().get_nodes_in_group(n):
			i.emit_signal('disable_physics')
		
	run_storyline()

## Signal method when the dialog is on the next line
func on_next():
	if line < len(stories) - 1:
		line += 1
		run_storyline()
	else:
		visible = false
		
		for n in dialogues_pause_physics_groupnames:
			for i in get_tree().get_nodes_in_group(n):
				i.emit_signal('enable_physics')
		
