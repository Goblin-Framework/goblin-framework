extends Camera3D
class_name CameraView3D

@export var player_character: NodePath
@export_category('Game event')
@export var is_cursor_player_navigate: bool = true
@export var signal_name_player_receive_information: String = 'receive_ray_information'
@export var cursor_interact: String = 'cursor_interact'
@export var cursor_select: String = 'cursor_select'
@export var z_length: float = 100.0

var _player_character: Actor3D
var _physics_space_world: PhysicsDirectSpaceState3D
var _orthogonal: Orthogonal

class Orthogonal:
	var _camera: CameraView3D
	var _z_length: float
	var _screen_pos: Vector2
	var _ray_query := PhysicsRayQueryParameters3D.new()
	
	func _init(node: CameraView3D, z_len: float):
		_camera = node
		_z_length = z_len
	
	func set_screen_position(value: Vector2) -> void:
		_screen_pos = value
	
	func get_ray_position():
		var origin_pos = _camera.project_ray_origin(_screen_pos)
		var target_pos = _camera.project_ray_normal(_screen_pos) * _z_length + origin_pos
		
		_ray_query.from = origin_pos
		_ray_query.to = target_pos
		_ray_query.collide_with_areas = true
		
		return _camera.get_physics_space_world().intersect_ray(_ray_query)

# Called when the node enters the scene tree for the first time.
func _ready():
	_player_character = get_node(player_character) if not player_character.is_empty() else get_parent()
	_physics_space_world = get_world_3d().direct_space_state
	
	if get_camera_projection().is_orthogonal():
		_orthogonal = Orthogonal.new($'.', z_length)

# Called every time event is triggered
func _input(event):
	if is_cursor_player_navigate:
		if event.is_action_pressed('cursor_interact'):
			if get_camera_projection().is_orthogonal():
				_orthogonal.set_screen_position(get_viewport().get_mouse_position())
				_player_character.emit_signal(signal_name_player_receive_information, _orthogonal.get_ray_position())

func get_physics_space_world() -> PhysicsDirectSpaceState3D:
	return _physics_space_world
