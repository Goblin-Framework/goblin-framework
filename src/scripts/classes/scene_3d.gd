extends PersistClass
class_name Scene3DClass

## Variable main node of the [Scene3D]
var _scene: Scene3D

## Method to set the main node of the [Scene3D]
func set_scene(n: Scene3D) -> void:
	_scene = n

## Return the [Scene3D] node
func get_scene() -> Scene3D:
	return _scene

## Variable collection of the [Stages3D] for [Scene3D]
var _stages: Array[Stage3D]

## Method to set an resources [Stages3D] in [Scene3D]
func append_stage(r: Resource) -> void:
	_stages.append(r.instantiate())

## Method to bulk add resources [Stages3D] in [Scene3D]
func set_stages(l: Array[Resource]) -> void:
	for i in l:
		append_stage(i)

## Return all the [Stages3D] in [Scene3D]
func get_stages() -> Array[Stage3D]:
	return _stages

## Variable collection of the [Actor3D] for [Scene3D]
var _playable_actors: Array[Actor3D]

## Method to set an resources [Actors3D] in [Scene3D]
func append_playable_actor(r: Resource) -> void:
	_playable_actors.append(r.instantiate())

## Method to bulk add resources [Actors3D] in [Scene3D]
func set_playable_actors(l: Array[Resource]) -> void:
	for i in l:
		append_playable_actor(i)

## Return all the [Actors3D] in [Scene3D]
func get_playable_actors() -> Array[Actor3D]:
	return _playable_actors
