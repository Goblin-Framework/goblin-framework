class_name Camera3DClass

## Variable reference for [Camera3D]
var _camera: Camera3D

## Set [Camera3D] into variable reference
func set_camera(node: Camera3D) -> void:
	_camera = node

## Return the variable reference [Camera3D]
func get_camera() -> Camera3D:
	return _camera

## Variable reference for cursor position [Vector2]
var _cursor: Vector2

## Set cursor position [Vector2] into variable reference
func set_cursor(pos: Vector2) -> void:
	_cursor = pos

## Return the variable reference cursor position [Vector2]
func get_cursor() -> Vector2:
	return _cursor

## Variable reference for physics process status
var _physics: bool = true

## A method to enable/activate physics process
func enable_physics() -> void:
	_physics = true
	get_camera().set_physics_process(_physics)

## A method to disable/deactivate physics process
func disable_physics() -> void:
	_physics = false
	get_camera().set_physics_process(_physics)

## Return the variable reference physics
func get_physics() -> bool:
	return _physics

## Variable reference for Z axis length value projection
var _z: float

## Set the value of Z axis length projection in world 3D
func set_z_length(value: float) -> void:
	_z = value

## Return the value of Z axis length projection in world 3D
func get_z_length() -> float:
	return _z

## Variable reference for size current viewport/display
var _viewport_size: Vector2

## Set the variable reference current viewport/display
func set_viewport_size(screen: Vector2) -> void:
	_viewport_size = screen

## Return the size viewport/display
func get_viewport_size() -> Vector2:
	return _viewport_size

## Variable reference for [CharacterBody3D] set in camera focused
var _actor: CharacterBody3D

## Set variable reference for [CharacterBody3D] in camera focused
func set_actor(node: CharacterBody3D):
	_actor = node

## Variable reference for [CharacterBody3D] set in camera focused
func get_actor() -> CharacterBody3D:
	return _actor

