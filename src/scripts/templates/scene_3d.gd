extends Scene3D
class_name Scene3DTemplate

## Main construct of the [Scene3D]
func construct_scene(o: Processor) -> void:
	# Checking the groupname whether is empty or else and then adding to group if the nodes is not in group
	assert(not groupname.is_empty() or groupname != '', Commons.LEVEL_GROUPNAME_REQUIRED)
	
	if not is_in_group(groupname):
		add_to_group(groupname)
	
	# Setting up the instance for scene when it's ready
	o.setup_player_actors()
	o.set_stages(stage_resources)

## Construct the [Scene3D] when it's entering the tree root project
func construct_scene_instantiate(o: Processor) -> void:
	construct_scene(o)
	
	# Setting up the instance for scene when it's enter tree
	o.reset_stage()
	o.set_active_stage_by_unique_name(stage_unique_name)
