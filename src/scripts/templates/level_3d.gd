extends Level3D
class_name Level3DTemplate

func construct_level_object(object: Base) -> void:
	# Checking the groupname whether is empty or else and then adding to group if the nodes is not in group
	assert(not groupname.is_empty() or groupname != '', Commons.actor_groupname_required)
	
	if not is_in_group(groupname):
		add_to_group(groupname)
	
	object.set_currency(currency)
	object.set_exp(exp)

func construct_level(node: Level3D) -> void:
	base = Base.new(node)
	base.initiate_stages(stages, 'leaving_current_stage')
	
	construct_level_object(base)
	
	switch_stage.connect(_on_switch_stages)

func _on_switch_stages(index: int) -> void:
	base.set_current_level_key(index)
	base.switch_to_current_stage('leaving_current_stage')
	print(base.get_switch_progress())
