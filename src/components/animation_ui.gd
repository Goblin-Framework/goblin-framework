extends Node
class_name AnimationUIComponent

## Target node path if not assigned the target node is the parent
@export var target: NodePath

@export_category('Animation')
## Set the origin of the [Control] into the center of their size
@export var center_origin: bool = true
## Set the animation will be parallel run or linear
@export var is_parallel: bool = true
## Define what properties will be animated
@export var properties: Array = ['size', 'scale', 'rotation', 'position', 'self_modulate']

@export_category('Mouse Over')
## Transition when mouse over in the target node
@export var hover_transition: Tween.TransitionType
## Easing when mouse over in the target node
@export var hover_ease: Tween.EaseType
## Time animation when mouse overed the target node
@export_range(.1, 10) var hover_seconds: float = .25
## Scale change when mouse overed during the animation tween
@export var hover_scale: Vector2 = Vector2(1, 1)
## Rotation change when mouse overed during the animation tween
@export_range(0, 360) var hover_rorate: float
## Override position when mouse overed during the animation tween
@export var hover_position: Vector2 = Vector2.ZERO
## Modulate changing when mouse overed during the animation tween
@export var hover_modulate: Color = Color.WHITE
## Override size when mouse overed during the animation tween
@export var hover_size: Vector2 = Vector2.ZERO

var _target: Control
var _default: Dictionary
var _default_transition: Tween.TransitionType
var _default_ease: Tween.EaseType
var _default_seconds: float
var _hover: Dictionary

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_target = get_parent() if target.is_empty() else get_node(target)
	
	_target.mouse_entered.connect(on_mouse_hover)
	_target.mouse_exited.connect(on_default)
	call_deferred('_construct')

func _construct():
	if center_origin:
		_target.pivot_offset = _target.size / 2
	
	_default = {
		'size': _target.size,
		'scale': _target.scale,
		'rotation': _target.rotation,
		'position': _target.position,
		'self_modulate': _target.modulate,
	}

	_hover = {
		'size': _target.size + hover_size,
		'scale': hover_scale,
		'rotation': _target.rotation + deg_to_rad(hover_rorate),
		'position': _target.position + hover_position,
		'self_modulate': hover_modulate,
	}

func _animate(values: Dictionary, prop: Array, seconds: float, transition_type: Tween.TransitionType, ease_type: Tween.EaseType) -> void:
	var tween = get_tree().create_tween()
	tween.set_parallel(is_parallel)
	
	for item in properties:
		tween.tween_property(_target, str(item), values[item], seconds).set_trans(transition_type).set_ease(ease_type)

func on_mouse_hover() -> void:
	_default_transition = hover_transition
	_default_ease       = hover_ease
	_default_seconds    = hover_seconds
	_animate(_hover, properties, hover_seconds, hover_transition, hover_ease)

func on_default() -> void:
	var reversal = properties
	reversal.reverse()
	
	_animate(_default, reversal, _default_seconds, _default_transition, _default_ease)
