extends Level3DClass
class_name Level3DProcessorClass

var current_level_key: int

func set_current_level_key(value: int) -> void:
	current_level_key = value

func get_current_level_key() -> int:
	return current_level_key

var _switch_progress_finished: bool = false

func switch_to_current_stage(signal_destruct: String) -> void:
	var current = get_stages()[get_current_level_key()]
	
	for i in get_level().get_children():
		# every children with class Node3D will be read as stage and will be cleaned-up
		if i.get_class() == 'Node3D':
			if i.has_signal(signal_destruct):
				i.emit_signal(signal_destruct)
				
			get_level().call_deferred('remove_child', i)
	
	get_level().call_deferred('add_child', current)
	_switch_progress_finished = true

func get_switch_progress() -> bool:
	return _switch_progress_finished
