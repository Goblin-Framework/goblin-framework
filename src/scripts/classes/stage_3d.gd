class_name Stage3DClass

## Variable reference for the [Node3D] stage
var _stage: Node3D

## Set the variable [Node3D] stage
func set_stage(node: Node3D) -> void:
	_stage = node

## Return value of [Node3D] stage
func get_stage() -> Node3D:
	return _stage

## Variable reference for the [Node3D] level
var _level: Node3D

## Set the variable [Node3D] level
func set_level(node: Node3D) -> void:
	_level = node

## Return value of [Node3D] level
func get_level() -> Node3D:
	return _level

## Variable reference for lists array of [Area3D] edges area
var _area_edges: Array[Area3D]

## Set the variable lists array of [Area3D] edges area
func set_area_edges(lists: Array[Area3D]) -> void:
	_area_edges = lists

## Return value of lists array of [Area3D] edges area
func get_area_edges() -> Array[Area3D]:
	return _area_edges

## Variable reference for lists array of [Node3D] spawn_points player
var _spawn_points: Array[Node3D]

## Set the variable lists array of [Node3D] spawn_points player
func set_spawn_points(lists: Array[Node3D]) -> void:
	_spawn_points = lists

## Return value of lists array of [Node3D] spawn_points player
func get_spawn_points() -> Array[Node3D]:
	return _spawn_points
