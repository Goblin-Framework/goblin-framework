extends PersistClass
class_name Stage3DClass

## Variable main node of the [Stage3D]
var _stage: Stage3D

## Set the node of the [Stage3D]
func set_stage(n: Stage3D) -> void:
	_stage = n

## Return node [Stage3D]
func get_stage() -> Stage3D:
	return _stage

## Variable node of the [Scene3D]
var _scene: Scene3D

## Set the node of the [Scene3D]
func set_scene(n: Scene3D) -> void:
	_scene = n

## Return node [Scene3D]
func get_scene() -> Scene3D:
	return _scene

## Variable node of the [CamView3D] in the [Stage3D]
var _camviews: Array[CamView3D]

## Method to set an resources [CamViews3D] in [Scene3D]
func append_camview(r: NodePath) -> void:
	_camviews.append(get_stage().get_node(r))

## Method to bulk add resources [CamViews3D] in [Scene3D]
func set_camviews(l: Array[NodePath]) -> void:
	for i in l:
		append_camview(i)

## Return all the [CamViews3D] in [Scene3D]
func get_camviews() -> Array[CamView3D]:
	return _camviews

## Variable node of the [Node3D] in the [Stage3D]
var _actor_posts: Array[Node3D]

## Method to set an resources [Nodes3D] in [Scene3D]
func append_actor_post(r: NodePath) -> void:
	_actor_posts.append(get_stage().get_node(r))

## Method to bulk add resources [Nodes3D] in [Scene3D]
func set_actor_posts(l: Array[NodePath]) -> void:
	for i in l:
		append_actor_post(i)

## Return all the [Nodes3D] in [Scene3D]
func get_actor_posts() -> Array[Node3D]:
	return _actor_posts
