extends Camera3DComponent
class_name Camera3DNavPathActorsComponent

## Node path for playable [Actor3D]
@export var playable_actors: Array[NodePath]
## Signal name for playable [Actor3D] when camera is pointing to object
@export var signal_name_interact: String = 'receive_pointing_camera_information'
@export var area_collision: bool = false

@export_category('Inputs')
## Input name when cursor is interacting to object/colliision
@export var cursor_interact_input: String = 'cursor_interact'
## Input name when cursor is selecting to object/colliision
@export var cursor_select_input: String = 'cursor_select'
## Delay event when interact is triggered
@export var delay_interact_secs: float = .75

var _timer: Timer = Timer.new()
var _players: Array[Actor3DNavPathComponent]
var _intearct: bool = true
var _navigation_path: NavigationPath

class NavigationPath extends TopDown:
	var _area_collision: bool
	
	func _init(node: Camera3DNavPathActorsComponent, z_length: float, area_collision: bool):
		super(node, z_length)
		_area_collision = area_collision
	
	func get_cursor_point() -> Dictionary:
		return cursor_in_world_3d(
			get_camera_cursor_point().origin,
			get_camera_cursor_point().target,
			_area_collision
		)

func set_camera_navpath_component(node: Camera3DNavPathActorsComponent):
	# connecting event for disable/enable physics.
	set_camera_top_down_component($'.')
	
	_timer.autostart = false
	_timer.timeout.connect(on_delay_timer_timeout)
	call_deferred('add_child', _timer)
	
	_navigation_path = NavigationPath.new(node, z_length, area_collision)
	_navigation_path.set_world_3d_space(get_world_3d().direct_space_state)
	
	if not playable_actors.is_empty():
		_players = []
		
		for item in playable_actors:
			if not item.is_empty():
				_players.append(get_node(item))
	
func on_delay_timer_timeout() -> void:
	_intearct = true

func deactive_interact() -> void:
	_intearct = false
	_timer.start(delay_interact_secs)

func set_camera_navpath_interact_physics_process(cursor: Vector2) -> void:
	if Input.get_action_strength(cursor_interact_input) > 0 and not _players.is_empty() and _intearct:
		_navigation_path.set_cursor_pos(cursor)
		
		for actor in _players:
			actor.emit_signal(
				signal_name_interact,
				_navigation_path.get_cursor_point()
			)
		
		deactive_interact()
