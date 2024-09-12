extends Stage3D
class_name Stage3DTemplate

## Main construct of the [Stage3D]
func construct_stage(o: Processor) -> void:
	# Checking the groupname whether is empty or else and then adding to group if the nodes is not in group
	assert(not groupname.is_empty() or groupname != '', Commons.LEVEL_GROUPNAME_REQUIRED)
	
	if not is_in_group(groupname):
		add_to_group(groupname)
	
	o.set_scene(o.get_stage().get_parent_node_3d())
	
	# Setup stage for post and camview
	o.set_camviews(camviews)
	o.set_actor_posts(actor_player_posts)
	
	# Reset camview and set by unique
	o.reset_camviews()
	o.set_camview_by_unique_name(camview_unique_name)

## Construct the [Scene3D] when it's entering the tree root project
func construct_scene_instantiate(o: Processor) -> void:
	construct_stage(o)

