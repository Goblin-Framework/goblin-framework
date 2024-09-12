extends Node3D
class_name Scene3D

## Signal to swap the [Stage3D] based on it's unique key
signal swap_stage(unique_key: String)

## Variable group name for the node [Level3D]
@export var groupname: String = 'scene'

@export_subgroup('Setup')
## Variable path collections to instantiate the player [Actor3D] in the [Scene3D]
@export var player_actor_paths: Array[String]
## Variable resource collection to instantiate the [Stage3D] into the [Scene3D]
@export var stage_resources: Array[Resource]
## Variable unique key stage for starter when [Scene3D] loaded
@export var stage_unique_name: String

## A main processor class of the [Scene3D]
class Processor extends Scene3DProcessorClass:
	
	## Constructor method class [Scene3D.Processor]
	func _init(n: Scene3D) -> void:
		set_scene(n)
	
	## Method to setup the player [Actor3D] into the [Scene3D]
	func setup_player_actors() -> void:
		var player: Array[Resource]
		
		for i in get_scene().player_actor_paths:
			# assertion if the resource load path is valid then continue to instantiate the [Actor3D]
			assert(ResourceLoader.exists(i), Common.Exception.path_not_found(i))
			player.append(load(i))
		
		set_playable_actors(player)

## Variable object class reference [Scene3D.Processor]
var processor: Processor
