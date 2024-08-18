class_name Camera3DClass

## Variable reference for [Camera3D]
var _node: Camera3D

## Set [Camera3D] into variable reference
func set_camera(node: Camera3D) -> void:
	_node = node

## Return the variable reference [Camera3D]
func get_camera() -> Camera3D:
	return _node

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
	_node.set_physics_process(_physics)

## A method to disable/deactivate physics process
func disable_physics() -> void:
	_physics = false
	_node.set_physics_process(_physics)

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

var _viewport_size: Vector2

func set_viewport_size(screen: Vector2) -> void:
	_viewport_size = screen

func get_viewport_size() -> Vector2:
	return _viewport_size

var _actor: CharacterBody3D

func set_actor(node: CharacterBody3D):
	_actor = node

func get_actor() -> CharacterBody3D:
	return _actor

