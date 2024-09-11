extends Node3D
class_name Stage3D

## Signal to dismantle the [Stage3D]
signal dismantle

signal assemble

## Variable group name for the node [Stage3D]
@export var groupname: String = 'stage'

@export_subgroup('Setup')
## Variable node collections [CamView3D] in the [Stage3D]
@export var camviews: Array[NodePath]
@export var camview_unique_name: String
@export var actor_player_posts: Array[NodePath]
@export var actor_player_post_index: int

#TODO: tambahkan comment dokumentasi pada method disini

class Processor extends Stage3DProcessorClass:
	func _init(n: Stage3D):
		set_stage(n)
	
	func set_first_actor_to_post_by_index(v: int) -> void:
		var actor = get_scene().processor.get_playable_actors()[0]
		var post  = get_actor_posts()[v]
		
		post.call_deferred('add_child', actor)

var processor: Processor
