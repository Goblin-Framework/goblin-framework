extends PersistsClass
class_name StageClass

## A base class to handle the stage that played
##
## Class for managing stages in the current scene, level, or scenario.

## A constant variable of the groupname of the [Level]
const GROUPNAME = 'stage'

## A constant variable to defined the error parent of the [Level]
const ERROR_PARENT = 'Fatal Error! The node must be a child of \'Stage\' node:'

## Variable to reference type of the node [Level] on development mode
var development: bool = true

## Variable references of the [Level] node
var level: Level

## variable main node of the [Stage]
var node: Stage:
	set(n):
		if !development:
			assert(n.get_parent_node_3d() is Level, ERROR_PARENT + n.name)
			level = n.get_parent_node_3d()
			
		node        = n
		persists    = node
		groupname   = GROUPNAME
		
	get:
		return node

## Variable collection nodes of the [Camera] in [Stage]
var cameras: Array[Camera]

## Variable active node of the [Camera] in [Stage]
var active_camera: Camera

## A metnod to set the activate camera by finding the match uid of the [Camera]
func activate_camera(v: String) -> void:
	for i in cameras:
		if i.unique_id == v:
			active_camera = i
			return

## Variable collection nodes of the [Node3D] in [Stage]
var posts: Array[Node3D]

## Variable active node of the [Node3D] in [Stage]
var active_post: Node3D

## A metnod to set the activate post by finding the match uid of the [Node3D]
func activate_post(v: int) -> void:
	active_post = posts[v]
	return
