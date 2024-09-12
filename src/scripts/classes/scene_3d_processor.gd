extends Scene3DClass
class_name Scene3DProcessorClass

## Variable to get the active [Stage3D] in [Scene3D]
var _active_stage: Stage3D

## Reset all the [Stage3D] that has been entered the tree in [Scene3D]
func reset_stage() -> void:
	# Iterate all the children from the scene and remove it
	for i in get_stages():
		# before scene has to be remove the stage as child it needs to be dismantle first by emit signal
		assert(i.has_signal('dismantle'), Common.Exception.signal_not_found('dismantle', i))
		i.emit_signal('dismantle')
		
		if i.get_parent_node_3d() == get_scene():
			get_scene().remove_child(i)

## Set the active stage by unique key and add it as child in [Scene3D]
func set_active_stage_by_unique_name(k: String) -> void:
	# Iterate all the collection stage from variable collection and return if key is captured
	for i in get_stages():
		assert(i.has_method('get_unique_name'), Common.Exception.method_not_found(i))
		
		# When the unique key and parameter are match then set the active stage and add it as child
		if i.get_unique_name() == k:
			_active_stage = i
			
			get_scene().add_child(_active_stage)
			assert(_active_stage.has_signal('assemble'), Common.Exception.signal_not_found('assemble', _active_stage))
			_active_stage.emit_signal('assemble')
			return

## Return the active stage in [Scene3D]
func get_active_stage() -> Stage3D:
	return _active_stage
