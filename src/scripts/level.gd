extends Node3D
class_name Level


## Signal trigger load [Stage] to [Scene]
signal load_stage

## User identifier name (uid) it's a custom variable for key in object to represet the identifier unique of every [Level] registered
var uid: String

## Variable path node location of the loading UI [Control] for the assembling the [Stage] in [Level]
@export var loading: NodePath
## Resources collection of the [Stage] in this current [Level]
@export var stages: Array[Resource]

@export_category('Development')
@export var development_mode: bool = true
@export_subgroup('Stage')
## Variable to set the User identifier name (uid) for the [Stage] that will be played in the [Level]
@export var stage_uid: String
## Variable to set the User identifier name (uid) for the [Camera] in [Stage] that will be played in the [Level]
@export var camera_uid: String
## Variable to set the post index of the [Stage] that will be played in the [Level]
@export var post: int

class Classes extends LevelClass:
	var loading: Control
	
	# Called when the object class is constructed for the first time
	func _init(n: Level) -> void:
		development = n.development_mode
		node        = n
		stages      = instantiate_stages()
		loading     = node.get_node_or_null(node.loading)
	
	## A simple method to define then stages resources into instantiated node object of the [Stage] and appending it into collection [Array]
	func instantiate_stages() -> Array[Stage]:
		var _stages: Array[Stage]
		for i in node.stages:
			_stages.append(i.instantiate())
		return _stages
	
	## A simple method to instantiate players 
	func instantiate_players(v: Array[Resource]) -> Array[Actor]:
		var _players: Array[Actor]
		for i in v:
			_players.append(i.instantiate())
		return _players
	
	## A simple method to reset and assemble the collection of the [Stage] that has been defined from the variable references inside the class
	func assemble_stage() -> void:
		for i in stages:
			if i.get_parent_node_3d() is Level and i.get_parent_node_3d() != null:
				node.remove_child(i)
		
		activate_stage(node.stage_uid)
		node.call_deferred('add_child', active_stage)
	
	## A simple method to get the only first value of the [Array] collections of [Actor] and then return it
	func first_player() -> Actor:
		return players[0]

var loaded: bool = false

var classes: Classes

## Return the get class as custom class_name
func get_class(): return 'Level'

## Set the is class if name is match with get_class or super
func is_class(v: String): return v == get_class() or super(v)

