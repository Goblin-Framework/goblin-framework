extends Camera3DComponent
class_name Camera3DNavigatedActorComponent

## Node path for playable [Actor3D]
@export var playable_actors: Array[NodePath]
## Signal name for playable [Actor3D] when camera is pointing to object
@export var signal_name_interact: String = 'receive_pointing_camera_information'
## Enable/Disable the projection interaction or select with area collision coverage
@export var area_collision: bool = false
## Key index for focusing which actor to be selected
@export var key_actor_focus: int = 0

@export_category('Inputs')
## Input name when cursor is interacting to object/colliision
@export var cursor_interact_input: String = 'cursor_interact'
## Input name when cursor is selecting to object/colliision
@export var cursor_select_input: String = 'cursor_select'
## Delay event when interact is triggered
@export var delay_interact_secs: float = .75

class NavigationActor extends PhysicsTopDown:
	var _space_world_3d: PhysicsDirectSpaceState3D

	func _init(camera: Camera3DNavigatedActorComponent, z_length: float, sensitivity: float):
		super(camera, sensitivity)
		set_z_length(z_length)
	
	func set_world_space_3D(value: PhysicsDirectSpaceState3D) -> void:
		_space_world_3d = get_camera().get_world_3d().direct_space_state
	
	func get_world_space_3D() -> PhysicsDirectSpaceState3D:
		return _space_world_3d
	
	func set_events_interact_by_cursor(collide_with_area: bool) -> void:
		projecting_camera_ray()
		set_world_3D_projection_ray(get_world_space_3D(), collide_with_area)

var _timer: Timer = Timer.new()
var _interact: bool = true

var _players: Array[Actor3DNavPathComponent]
var _navigation_actor: NavigationActor

func setup_camera_navigated_actor(camera: Camera3DNavigatedActorComponent, sensitivity: float):
	setup_camera_top_down_angle(camera, sensitivity)
	
	_timer.autostart = false
	_timer.timeout.connect(on_delay_timer_timeout)
	call_deferred('add_child', _timer)
	
	_navigation_actor = NavigationActor.new(camera, z_length, sensitivity)
	_navigation_actor.set_world_space_3D(get_world_3d().direct_space_state)
	
	if not playable_actors.is_empty():
		_players = []
		
		for item in playable_actors:
			if not item.is_empty():
				_players.append(get_node(item))

## Physics process for the [Camera3DNavPathActorsComponent] such as interact, select , etc. Call this method in _physics_process
func physics_process_camera_navigated(delta: float) -> void:
	_navigation_actor.set_cursor(get_viewport().get_mouse_position())
	
	if Input.get_action_strength(cursor_interact_input) > 0 and not _players.is_empty() and _interact:
		_navigation_actor.set_events_interact_by_cursor(area_collision)
		
		for actor in _players:
			actor.emit_signal(
				signal_name_interact,
				_navigation_actor.get_world_3D_projection_ray()
			)
		
		deactive_interact()

## Method for execute action when timer is timeout
func on_delay_timer_timeout() -> void:
	_interact = true

## An simple method to deactive interact and starting the timer
func deactive_interact() -> void:
	_interact = false
	_timer.start(delay_interact_secs)

func get_active_actor() -> Actor3DNavPathComponent:
	return _players[key_actor_focus]

func set_camera_actor_navigated(node: CharacterBody3D) -> void:
	_navigation_actor.set_actor(node)
