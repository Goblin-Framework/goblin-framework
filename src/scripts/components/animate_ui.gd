extends Node
class_name AnimateUIComponent
## Main component for User-Interface nodes 

enum EVENT_TYPE {MOUSE_OVER, PRESSED, FOCUSED}

var _target: Control
var _default: Dictionary
var _fired: Dictionary
var _default_transition: Tween.TransitionType
var _default_ease: Tween.EaseType
var _default_seconds: float

@export_category('Animation')
## Set the origin of the [Control] into the center of their size
@export var center_origin: bool = true
## Set the animation will be parallel run or linear
@export var is_parallel: bool = true
## Define what properties will be animated
@export var properties: Array = ['size', 'scale', 'rotation', 'position', 'self_modulate']

@export_category('Events')
## Type of events that firing animation for UI
@export_enum('Mouse over', 'Pressed', 'Focused') var event_type: int = 0
## Time animation is playing from start to finish
@export_range(.1, 5) var seconds: float = .25

@export_subgroup("Transtiion and Ease")
## Transition when events target is triggered
@export var event_transition: Tween.TransitionType
## Easing when events target is triggered
@export var event_ease: Tween.EaseType
@export_subgroup("Properties")
## Animation vector for scale changing
@export var event_scale: Vector2 = Vector2(1, 1)
## Animation value for rotation changing
@export_range(0, 360) var event_rotate: float
## Animation vector for position changing
@export var event_position: Vector2 = Vector2.ZERO
## Animation color for modulation modified
@export var event_modulate: Color = Color.WHITE
## Animation vector for size changing
@export var event_size: Vector2 = Vector2.ZERO

func _ready():
	_target = get_parent()
	
	if event_type == EVENT_TYPE.MOUSE_OVER:
		_target.mouse_entered.connect(_on_event_up)
		_target.mouse_exited.connect(_on_event_down)
	
	elif event_type == EVENT_TYPE.PRESSED:
		_target.button_down.connect(_on_event_up)
		_target.button_up.connect(_on_event_down)
	
	elif event_type == EVENT_TYPE.FOCUSED:
		_target.focus_entered.connect(_on_event_up)
		_target.focus_exited.connect(_on_event_down)
	
	call_deferred('construct_ui_base')

func construct_ui_base() -> void:
	if center_origin:
		_target.pivot_offset = _target.size / 2
		
	_default = {
		'size': _target.size,
		'scale': _target.scale,
		'rotation': _target.rotation,
		'position': _target.position,
		'self_modulate': _target.modulate,
	}

	_fired = {
		'size': _target.size + event_size,
		'scale': event_scale,
		'rotation': _target.rotation + deg_to_rad(event_rotate),
		'position': _target.position + event_position,
		'self_modulate': event_modulate,
	}

func _animate(values: Dictionary, prop: Array, seconds: float, transition_type: Tween.TransitionType, ease_type: Tween.EaseType) -> void:
	var tween = get_tree().create_tween()
	tween.set_parallel(is_parallel)
	
	for item in properties:
		tween.tween_property(_target, str(item), values[item], seconds).set_trans(transition_type).set_ease(ease_type)


func _on_event_up() -> void:
	_default_transition = event_transition
	_default_ease       = event_ease
	_default_seconds    = seconds
	_animate(_fired, properties, _default_seconds, _default_transition, _default_ease)

func _on_event_down() -> void:
	var reversal = properties
	reversal.reverse()
	
	_animate(_default, reversal, _default_seconds, _default_transition, _default_ease)
