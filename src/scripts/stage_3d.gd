extends Node3D
class_name Stage3D

class Base extends Stage3DProcessorClass:
	func _init(node: Node3D):
		set_stage(node)
	
	func set_actor_to_spawn_point(actor: CharacterBody3D, idx: int) -> void:
		var spawn_point = get_spawn_points()[idx]
		spawn_point.call_deferred('add_child', actor)
	
	func set_camera_to_spawn_point(camera: Camera3D, idx: int) -> void:
		var spawn_point = get_spawn_points()[idx]
		spawn_point.call_deferred('add_child', camera)
		camera.current = true
	
	func del_actor_from_spawn_point(actor: CharacterBody3D, idx: int) -> void:
		var spawn_point = get_spawn_points()[idx]
		spawn_point.call_deferred('remove_child', actor)
		
	func del_camera_from_spawn_point(camera: Camera3D, idx: int) -> void:
		var spawn_point = get_spawn_points()[idx]
		spawn_point.call_deferred('remove_child', camera)
		camera.current = false

signal leaving_current_stage

## Variable group name for the node [Inventory]
@export var groupname: String = 'stage'
@export var actor_player: Resource
@export var camera_view: Resource
@export var spawn_points: Array[NodePath]
@export var area_edges: Array[NodePath]

var base: Base
