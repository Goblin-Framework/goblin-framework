@tool
extends EditorPlugin

const PRE_CONFIGURATIONS = {
	'display/window/size/viewport_width': 1600,
	'display/window/size/viewport_height': 900,
	'framework/components/dialogues/speed': .5
}

const INPUT_MAP = {
	'zoom_in': [MOUSE_BUTTON_WHEEL_DOWN, ], 
	'zoom_out': [MOUSE_BUTTON_WHEEL_UP, ],
	'reset_view': [KEY_1, ],
	'cursor_interact': [MOUSE_BUTTON_RIGHT, ],
	'cursor_select': [MOUSE_BUTTON_LEFT, ]
}

func _def_config(key: String, value: Variant) -> void:
	if not ProjectSettings.has_setting(key):
		ProjectSettings.set_setting(key, value)
	ProjectSettings.set_initial_value(key, value)
	print('Set settings %s : %s' % [key, str(value)])

func _def_input(key: String, events: Array) -> void:
	var event
	
	if not InputMap.has_action(key):
		InputMap.add_action(key)
		
		for i in events:
			event = InputEventKey.new()
			event.scancode = i
			InputMap.action_add_event(key, event)

func _enter_tree() -> void:
	print('plugin enter tree')
	
	# Initialization of the plugin goes here.
	for i in PRE_CONFIGURATIONS:
		_def_config(i, PRE_CONFIGURATIONS[i])
	
	ProjectSettings.save()
func _exit_tree():
	pass
