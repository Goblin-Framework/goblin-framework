extends Node3D
class_name Level3D

class Base extends Level3DProcessorClass:
	func _init(node: Level3D) -> void:
		set_level(node)
	
	func initiate_stages(lists: Array[Resource], signal_name: String) -> void:
		for i in lists:
			insert_stage(i.instantiate())
		
		set_current_level_key(0)
		switch_to_current_stage(signal_name)

signal switch_stage(index: int)

## Variable group name for the node [Inventory]
@export var groupname: String = 'level'

@export var stages: Array[Resource]

@export var currency: float

@export var exp: float

var base: Base
