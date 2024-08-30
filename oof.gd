@tool
extends EditorPlugin

const PRE_CONFIGURATIONS = {
	'display/window/size/viewport_width': 1600,
	'display/window/size/viewport_height': 900,
	'framework/components/dialogues/speed': .5
}

func _def_config(key: String, value: Variant) -> void:
	if not ProjectSettings.has_setting(key):
		ProjectSettings.set_setting(key, value)
	ProjectSettings.set_initial_value(key, value)
	print('Set settings %s : %s' % [key, str(value)])

func _enter_tree() -> void:
	# Initialization of the plugin goes here.
	for i in PRE_CONFIGURATIONS:
		_def_config(i, PRE_CONFIGURATIONS[i])
	ProjectSettings.save()
	
	
func _exit_tree():
	pass
