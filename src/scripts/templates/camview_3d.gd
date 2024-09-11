extends CamView3D
class_name CamView3DTemplate

#TODO: tambahkan comment dokumentasi pada method disini

func construct_camview(o: Physics) -> void:
	# Checking the groupname whether is empty or else and then adding to group if the nodes is not in group
	assert(not groupname.is_empty() or groupname != '', Commons.LEVEL_GROUPNAME_REQUIRED)
	
	if not is_in_group(groupname):
		add_to_group(groupname)
		
	enable_physics.connect(o.enable_physics)
	disable_physics.connect(o.disable_physics)

func construct_camview_top_down_enter_tree(o: TopDown) -> void:
	construct_camview(o)

func destruct_camview_top_down_exit_tree(o: TopDown) -> void:
	enable_physics.disconnect(o.enable_physics)
	disable_physics.disconnect(o.disable_physics)

func physics_process_camview(o: Physics) -> void:
	var cursor = get_viewport().get_mouse_position()
	
	o.set_cursor(cursor)
	o.set_zoom_step(zoom_step)
	o.set_viewport_size(get_viewport().get_window().size)

func physics_process_camview_screen_edges(o: Physics) -> void:
	if o.get_cursor_edges() == 'up':
		follow_actor = false
		o.upward()
	
	if o.get_cursor_edges() == 'down':
		follow_actor = false
		o.downward()
	
	if o.get_cursor_edges() == 'left':
		follow_actor = false
		o.leftward()
	
	if o.get_cursor_edges() == 'right':
		follow_actor = false
		o.rightward()

func physics_process_camview_top_down(o: TopDown) -> void:
	o.projecting_camera_ray()
	physics_process_camview(o)
	
	if screen_edges:
		physics_process_camview_screen_edges(o)
	
	if follow_actor and o.get_actor() != null:
		o.follow_actor()
	
func input_camview_zoom(e: InputEvent, o: Physics) -> void:
	if e.get_action_strength(zoom_in_input) > 0:
		o.zoom_in(min_zoom)
	
	if e.get_action_strength(zoom_out_input) > 0:
		o.zoom_out(max_zoom)
