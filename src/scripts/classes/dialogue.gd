extends PersistClass
class_name DialogueClass

# Variable reference of the main node dialogue as Dialogue
var _dialogue: Dialogue

## Set the variable [Dialogue]
func set_dialogue(n: Dialogue) -> void:
	_dialogue = n

## Return the variable [Dialogue]
func get_dialogue() -> Dialogue:
	return _dialogue

# Variable reference of the main node of the logs textarea as RichTextLabel
var _log_textarea: RichTextLabel

## Set the variable [RichTextLabel]
func set_log_textarea(n: RichTextLabel) -> void:
	_log_textarea = n

## Return the variable [RichTextLabel]
func get_log_textarea() -> RichTextLabel:
	return _log_textarea

# Variable reference of the main node of the active label name as Label
var _active_label: Label

## Set the variable primary [Label]
func set_active_label(n: Label) -> void:
	_active_label = n

## Return the variable primary [Label]
func get_active_label() -> Label:
	return _active_label

# Variable reference of the main node of the primary label name as Label
var _primary_label: Label

## Set the variable secondary [Label]
func set_primary_label(n: Label) -> void:
	_primary_label = n

## Return the variable secondary [Label]
func get_primary_label() -> Label:
	return _primary_label

# Variable reference animation time interval in seconds float
var _time: float

## Set the variable of the time interval animated text 
func set_time(v: float) -> void:
	_time = v

## Return the variable of the time interval animated text 
func get_time() -> float:
	return _time

# Variable logs data of the dialogue such as text strings or callable
var _logs: Array[Variant]

## Set the variable of the logs in dialogue
func set_logs(v: Array[Variant]) -> void:
	_logs = v

## Return the variable of the logs in dialogue
func get_logs() -> Array[Variant]:
	return _logs

# Variable name data of the dialogue that will be appear in the dialogue
var _name: Dictionary

## Set the variable of the name in dialogue
func set_name(v: Dictionary) -> void:
	_name = v

## Return the variable of the name in dialogue
func get_name() -> Dictionary:
	return _name

# Variable sprite data of the dialogue that will be appear in the dialogue
var _sprite: Dictionary

## Set the variable of the sprite in dialogue
func set_sprite(v: Dictionary) -> void:
	_sprite = v

## Return the variable of the sprite in dialogue
func get_sprite() -> Dictionary:
	return _sprite

# Variable line logs from the current dialogue
var _line: int

## Set the variable row of the line in dialogue
func set_line(v: int) -> void:
	_line = v

## Method to skip the row line into position
func skip_line(v: int) -> void:
	_line += v

## Return the variable of the line in dialogue
func get_line() -> Variant:
	return get_logs()[_line]

# Tween variable that will utilities for the animation the logs textarea
var _tween: Tween

## Animate the property tween
func tween_animation() -> void:
	_tween = get_dialogue().get_tree().create_tween()
	_tween.tween_property(get_log_textarea(), 'visible_ratio', 1, get_time())

## Return the tween variable
func get_tween() -> Tween:
	return _tween
