class_name Level3DClass

## Variable reference for [Node3D] main game
var _level: Node3D

## Set the variable reference [Node3D] main game
func set_level(node: Node3D) -> void:
	_level = node

## Return the variable reference [Node3D] main game
func get_level() -> Node3D:
	return _level

## Variable reference for currency in game
var _currency: float

## Set the variable reference currency in game
func set_currency(value: float) -> void:
	_currency = value

## Return the variable reference currency in game
func get_currency() -> float:
	return _currency

## Variable reference for experience in game
var _exp: float

## Set the variable reference experience in game
func set_exp(value: float) -> void:
	_exp = value

## Return the variable reference experience in game
func get_exp() -> float:
	return _exp

## Variable reference for stages available in the game
var _stages: Array[Node3D]

## Set the bulk lists of the stages
func set_stages(lists: Array[Node3D]) -> void:
	_stages = lists

## Insert a stage to the lists
func insert_stage(node: Node3D) -> void:
	_stages.append(node)

## Return the lists stages
func get_stages() -> Array[Node3D]:
	return _stages
