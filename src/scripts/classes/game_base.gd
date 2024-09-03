class_name Game3DClass

## Variable reference for [Node3D] main game
var _game: Node3D

## Set the variable reference [Node3D] main game
func set_game(node: Node3D) -> void:
	_game = node

## Return the variable reference [Node3D] main game
func get_game() -> Node3D:
	return _game

## Variable reference for currency in game
var _currency: int

## Set the variable reference currency in game
func set_currency(value: int) -> void:
	_currency = value

## Return the variable reference currency in game
func get_currency() -> int:
	return _currency

## Variable reference for experience in game
var _exp: float

## Set the variable reference experience in game
func set_exp(value: float) -> void:
	_exp = value

## Return the variable reference experience in game
func get_exp() -> float:
	return _exp
