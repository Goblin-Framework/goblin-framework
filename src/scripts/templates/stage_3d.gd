extends Stage3D
class_name Stage3DTemplate

var _actor_player: Actor3D
var _camview_node: CamView3D
var _level_node: Level3D

func construct_stage_object(object: Base) -> void:
		# Checking the groupname whether is empty or else and then adding to group if the nodes is not in group
	assert(not groupname.is_empty() or groupname != '', Commons.actor_groupname_required)
	
	if not is_in_group(groupname):
		add_to_group(groupname)
	
	object.reset_spawn_points()
	object.set_level(get_parent_node_3d())

func construct_stage(node: Stage3D) -> void:
	base = Base.new(node)
	
	construct_stage_object(base)
	
	_actor_player = actor_player.instantiate()
	_camview_node = camera_view.instantiate() if camera_view != null else null

func get_actor() -> Actor3D:
	return _actor_player

func get_camview() -> CamView3D:
	return _camview_node
