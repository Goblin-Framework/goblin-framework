extends Camera3D
class_name CameraOrthogonalNavigation

signal disable_physics
signal enable_physics

## Z length constant value for camera to collision
@export var z_length_constant := 100.0
## If the [Area3D] is count collision with camera point
@export var is_collide_with_area := false

@export_category('Actor player')
## Node path for playable [Actor3D]
@export var actor_player_character: NodePath
## Signal name for playable [Actor3D] when camera is pointing to object
@export var actor_signal_name_interact:= 'receive_pointing_camera_information'

@export_category('Input event')
## Event name when cursor is interacting to object/colliision
@export var cursor_interact_input := 'cursor_interact'
## Event name when cursor is selecting to object/colliision
@export var cursor_select_input := 'cursor_select'
## Delay event when interact is triggered
@export var delay_interact_secs := .75
@export var zoom_in_input := 'zoom_in'
@export var zoom_out_input := 'zoom_out'
## Step value when zoom event is fired
@export_range(.1, 2) var zoom_step := .25
## Minimum zoom value (Zoom-in)
@export_range(.5, 12) var min_zoom := 4.0
## Maximum zoom value (Zoom-out)
@export_range(8, 20) var max_zoom := 12.0

var _player: Actor3D
var _physics_space_world: PhysicsDirectSpaceState3D
var _event: Events
var _is_interact := true
var _is_paused:= false
var _timer := Timer.new()

class Events:
	var _z: float
	var _cursor: Vector2
	var _camera: CameraOrthogonalNavigation
	var _ray_query := PhysicsRayQueryParameters3D.new()
	
	## Properties information to tell the ray pointing whether collision area is count or not
	var is_colliding_with_area := false
	
	func _init(camera: CameraOrthogonalNavigation, z_length: float = 100.0):
		_camera = camera
		_z      = z_length
	
	## Set the cursor position from the screen
	func set_cursor_position(pos: Vector2) -> void:
		_cursor = pos
	
	## Method to get the cursor pointing information
	func get_point_information() -> Dictionary:
		var origin_pos = _camera.project_ray_origin(_cursor)
		var target_pos = _camera.project_ray_normal(_cursor) * _z + origin_pos
		
		_ray_query.from = origin_pos
		_ray_query.to   = target_pos
		_ray_query.collide_with_areas = _camera.is_collide_with_area
		
		return _camera.get_physics_space_world().intersect_ray(_ray_query)
	
	func zoom_in() -> void:
		if _camera.size >= _camera.min_zoom:
			_camera.size -= _camera.zoom_step
	
	func zoom_out() -> void:
		if _camera.size <= _camera.max_zoom:
			_camera.size += _camera.zoom_step

# Called when the node enters the scene tree for the first time.
func _ready():
	_player = get_parent() if actor_player_character.is_empty() else get_node(actor_player_character)
	_physics_space_world = get_world_3d().direct_space_state
	_event = Events.new($'.', z_length_constant)
	_event.is_colliding_with_area = is_collide_with_area
	_timer.timeout.connect(on_delay_interact_timeout)
	call_deferred('add_child', _timer)

func _input(event):
	if event.get_action_strength(zoom_in_input) > 0:
		_event.zoom_in()
	
	if event.get_action_strength(zoom_out_input) > 0:
		_event.zoom_out()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if Input.get_action_strength(cursor_interact_input) > 0 and _is_interact:
		_event.set_cursor_position(get_viewport().get_mouse_position())
		_player.emit_signal(actor_signal_name_interact, _event.get_point_information())
		_is_interact = false
		_timer.start(delay_interact_secs)

## Signal method for timer when intearction delay is timeout
func on_delay_interact_timeout():
	_is_interact = true if not _is_paused else false

## Method to get the physics space world 3D
func get_physics_space_world() -> PhysicsDirectSpaceState3D:
	return _physics_space_world

func on_disable_physics() -> void:
	_is_paused = true
	set_physics_process(false)

func on_enable_physics() -> void:
	_is_paused = false
	set_physics_process(true)