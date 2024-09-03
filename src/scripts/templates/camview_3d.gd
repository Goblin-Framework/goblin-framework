extends CamView3D
class_name CamView3DTemplate

var _enable_interaction: bool
var _actor_player: Array

func construct_camview_object(object: Base) -> void:
		# Checking the groupname whether is empty or else and then adding to group if the nodes is not in group
	assert(not groupname.is_empty() or groupname != '', Commons.camview_groupname_required)
	
	if not is_in_group(groupname):
		add_to_group(groupname)
	
	enable_physics.connect(object.enable_physics)
	disable_physics.connect(object.disable_physics)

func construct_camview_top_down(node: CamView3D, sensitivity: float) -> void:
	_enable_interaction = true
	
	top_down = TopDown.new(node, sensitivity)
	top_down.set_z_length(100.0)
	
	construct_camview_object(top_down)
	
	timer = Timer.new()
	timer.autostart = false
	timer.timeout.connect(_on_enable_interaction)
	
	if not playable_actors.is_empty():
		_actor_player = []
		
		for actor in playable_actors:
			if not actor.is_empty():
				_actor_player.append(get_node(actor))
	
	call_deferred('add_child', timer)

func physics_process_camview_object(delta: float, object: Base) -> void:
	var cursor = get_viewport().get_mouse_position()
	
	object.set_events_by_cursor(cursor, zoom_step)
	object.set_viewport_size(get_viewport().get_window().size)

func physics_process_camview_screen_edges(object: Base) -> void:
	if object.get_cursor_edges() == 'up':
		follow_actor = false
		object.upward()
	
	if object.get_cursor_edges() == 'down':
		follow_actor = false
		object.downward()
	
	if object.get_cursor_edges() == 'left':
		follow_actor = false
		object.leftward()
	
	if object.get_cursor_edges() == 'right':
		follow_actor = false
		object.rightward()

func physics_process_camview_navigate_click(object: Base) -> void:
	object.set_world_3D_projection_ray(get_world_3d().direct_space_state, area_collision)
	
	if Input.get_action_strength(cursor_interact_input) > 0 and not _actor_player.is_empty() and _enable_interaction:
		for actor in _actor_player:
			actor.emit_signal(
				signal_name_interact,
				object.get_world_3D_projection_ray()
			)
		
		_on_disable_interaction()


func physics_process_camview_top_down(delta: float) -> void:
	top_down.projecting_camera_ray()
	physics_process_camview_object(delta, top_down)
	
	if screen_edges:
		physics_process_camview_screen_edges(top_down)
	
	if follow_actor and top_down.get_actor() != null:
		top_down.follow_actor()
	
	physics_process_camview_navigate_click(top_down)

func input_camview_zoom(event: InputEvent, object: Base) -> void:
	if event.get_action_strength(zoom_in_input) > 0:
		object.zoom_in(min_zoom)
	
	if event.get_action_strength(zoom_out_input) > 0:
		object.zoom_out(max_zoom)

func input_camview_follow_actor_top_down() -> void:
	if Input.is_action_just_pressed(reset_view_input) and not follow_actor:
		follow_actor = true
		top_down.follow_actor()

func _on_enable_interaction() -> void:
	_enable_interaction = true

func _on_disable_interaction() -> void:
	_enable_interaction = false
	timer.start(delay_interact_interval)

func camview_top_down_active_actor() -> void:
	if not _actor_player.is_empty() and _actor_player[key_actor_focus]:
		top_down.set_actor(_actor_player[key_actor_focus])
