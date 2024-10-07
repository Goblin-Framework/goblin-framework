class_name PersistsClass

## Core class handler node with persistence
##
## Core class handling persistence for save/load state, input, processing, and group names.

## A constant to define the persist group name
const PERSIST = 'persist'

## Variable identification for the node wheter it persistence or not
var persists: Node:
	## Set the [Node] as persistence for save/load and state machine
	set(n):
		if !n.is_in_group(PERSIST):
			n.add_to_group(PERSIST, true)
		
		persists = n
	
	## Return the [Node] that has ben setted
	get:
		return persists

## Variable to set the main groupname as the categorize firstly it has to be persistence group
var groupname: StringName:
	## Set the [StringName] of the groupname
	set(v):
		if !persists.is_in_group(v):
			persists.add_to_group(v)
		
		groupname = v
	
	## Return the [StringName] of the groupname
	get:
		return groupname

## Variable to set the input status and it's process
var input_status: bool:
	## Set the input status and it's process
	set(v):
		persists.set_process_input(v)
		persists.set_process_unhandled_input(v)
		input_status = v
	
	## Return the input status value
	get:
		return input_status

## Variable to set the physics process status and it's process
var physics_process_status: bool:
	## Set the physics process status and it's process
	set(v):
		persists.set_physics_process(v)
		physics_process_status = v
	
	## Return the physics process status value
	get:
		return physics_process_status

## Variable to set the idle process status and it's process
var idle_process_status: bool:
	## Set the idle process status and it's process
	set(v):
		persists.set_process(v)
		idle_process_status = v
	
	## Return the idle process status value
	get:
		return idle_process_status

## A shortcut method to enable the input status and it's process
func enable_input() -> void:
	input_status = true

## A shortcut method to disable the input status and it's process
func disable_input() -> void:
	input_status = false

## A shortcut method to enable the physics_process status and it's process
func enable_physics_process() -> void:
	physics_process_status = true

## A shortcut method to disable the physics_process status and it's process
func disable_physics_process() -> void:
	physics_process_status = false

## A shortcut method to enable the idle_process status and it's process
func enable_idle_process() -> void:
	idle_process_status = true

## A shortcut method to disable the idle_process status and it's process
func disable_idle_process() -> void:
	idle_process_status = false
