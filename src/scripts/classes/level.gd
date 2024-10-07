extends PersistsClass
class_name LevelClass

## A base class to handle the level that played
##
## Class for managing stages in the current scene, level, or scenario.

## A constant variable of the groupname of the [Level]
const GROUPNAME = 'level'

## A constant variable to defined the error parent of the [Level]
const ERROR_PARENT = 'Fatal Error! The node must be a child of \'Root\' node:'

## Variable to reference type of the node [Level] on development mode
var development: bool = true

var node: Level:
	set(n):
		if !development:
			assert(n.get_parent() is Root, ERROR_PARENT + n.name)
			
		node        = n
		persists    = node
		groupname   = GROUPNAME
		
	get:
		return node

## Variable collection nodes of the [Actor] in [Scene]
var players: Array[Actor]

## Variable collection nodes of the [Stage] in [Scene]
var stages: Array[Stage]

## Variable active node of the [Stage] in [Scene]
var active_stage: Stage

## A metnod to set the activate stage by finding the match uid of the [Stage]
func activate_stage(v: String) -> void:
	for i in stages:
		if i.uid == v:
			active_stage = i
			return
