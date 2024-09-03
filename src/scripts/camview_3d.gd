extends Camera3D
class_name CamView3D

class Base extends Camera3DPhysicsClass:
	func _init(node: CamView3D):
		set_camera(node)

class TopDown extends Base:
	var _origin: Vector3
	
	func _init(node: CamView3D, sensitivity: float):
		super(node)
		set_cross_vector(Vector2(sensitivity, sensitivity * 1.5))
		
		_origin = get_camera().transform.origin
		
	func set_events_by_cursor(cursor: Vector2, step_zoom: float) -> void:
		set_cursor(cursor)
		set_zoom_step(step_zoom)
		projecting_camera_ray()
	
	func follow_actor() -> void:
		get_camera().transform.origin = _origin + get_actor().transform.origin

var _timer: Timer = Timer.new()
var _interact: bool = true
var _players: Array[Actor3D]

## Signal to trigger disable/deactivate physics_process
signal disable_physics
## Signal to trigger enable/activate physics_process
signal enable_physics

@export var groupname: String = 'camera'
## Input name when zoom in is fired
@export_subgroup('Inputs')
@export var zoom_in_input: String = 'zoom_in'
## Input name when zoom out is fired
@export var zoom_out_input: String = 'zoom_out'
@export_subgroup('Zoom')
## Step value when zoom events is fired
@export_range(.1, 1) var zoom_step: float = .25
## Minimum zoom value (Zoom-in)
@export_range(1, 99) var min_zoom: float = 4.0
## Maximum zoom value (Zoom-out)
@export_range(1, 99) var max_zoom: float = 12.0

@export_category('Top-down')
## Z length axis value between [Camera3D] to world 3D
@export var z_length: float = 100.0
## Enable/Disable camera movement based on cursor on the edges of screen
@export var screen_edges: bool = true
## Enable/Disable camera movement following [Actor3D]
@export var follow_actor: bool = true

@export_category('Point-Click')
## Enable/Disable the projection interaction or select with area collision coverage
@export var area_collision: bool = false
@export_subgroup('Inputs')
## Input name for reset view back to actor
@export var reset_view_input: String = 'reset_view'
## Input name when cursor is interacting to object/colliision
@export var cursor_interact_input: String = 'cursor_interact'
## Input name when cursor is selecting to object/colliision
@export var cursor_select_input: String = 'cursor_select'
## Number of interval delay when interact is inactive and active
@export_range(.1, 3) var delay_interact_interval: float = .5
@export_subgroup('Actors')
## Node path for playable [Actor3D]
@export var playable_actors: Array[NodePath]
## Signal name for playable [Actor3D] when camera is pointing to object
@export var signal_name_interact: String = 'receive_pointing_camera_information'
## Key index for focusing which actor to be selected
@export var key_actor_focus: int = 0

var top_down: TopDown

func construct_camera_base(object: Base) -> void:
		# Checking the groupname whether is empty or else and then adding to group if the nodes is not in group
	assert(not groupname.is_empty() or groupname != '', Commons.camview_groupname_required)
	
	if not is_in_group(groupname):
		add_to_group(groupname)
	
	enable_physics.connect(object.enable_physics)
	disable_physics.connect(object.disable_physics)

func construct_camera_top_down(node: CamView3D, sensitivity: float) -> void:
	top_down = TopDown.new(node, sensitivity)
	top_down.set_z_length(100.0)
	
	construct_camera_base(top_down)
	
	_timer.autostart = false
	_timer.timeout.connect(on_delay_timer_timeout)
	call_deferred('add_child', _timer)
	
	if not playable_actors.is_empty():
		_players = []
		
		for item in playable_actors:
			if not item.is_empty():
				_players.append(get_node(item))

func physics_process_camera_base(delta: float, object: Base) -> void:
	var cursor = get_viewport().get_mouse_position()
	
	object.set_events_by_cursor(cursor, zoom_step)
	object.set_viewport_size(get_viewport().get_window().size)
	
	if screen_edges:
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
	
	if follow_actor and object.get_actor() != null:
		object.follow_actor()

func physics_process_camera_point_click(delta: float) -> void:
	physics_process_camera_base(delta, top_down)
	top_down.set_world_3D_projection_ray(get_world_3d().direct_space_state, area_collision)
	
	if Input.get_action_strength(cursor_interact_input) > 0 and not _players.is_empty() and _interact:
		for actor in _players:
			actor.emit_signal(
				signal_name_interact,
				top_down.get_world_3D_projection_ray()
			)
		
		deactive_interact()

func input_camera_follow_actor() -> void:
	if Input.is_action_just_pressed('reset_view') and not follow_actor:
		follow_actor = true
		top_down.follow_actor()

func input_camera_zoom(event) -> void:
	if event.get_action_strength(zoom_in_input) > 0:
		top_down.zoom_in(min_zoom)
		
	if event.get_action_strength(zoom_out_input) > 0:
		top_down.zoom_out(max_zoom)

## Method for execute action when timer is timeout
func on_delay_timer_timeout() -> void:
	_interact = true

## An simple method to deactive interact and starting the timer
func deactive_interact() -> void:
	_interact = false
	_timer.start(delay_interact_interval)

func top_down_active_actor() -> void:
	if not _players.is_empty() and _players[key_actor_focus]:
		top_down.set_actor(_players[key_actor_focus])
