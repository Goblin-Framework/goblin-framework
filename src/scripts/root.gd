extends Node
class_name Root

signal new_game

## Main menu variable node
@export var main_menu: NodePath
## Collections of levels
@export var levels: Array[NodePath]

class Classes extends RootClass:
	var _levels: Array[Level]
		
	func _init(n: Root):
		node = n
		
		main_menu = node.get_node_or_null(node.main_menu)
		
		# iterate the collection of nodepath levels to the node object and append to temporary array
		for i in node.levels:
			_levels.append(node.get_node_or_null(i))
		levels = _levels
	
	func load_players(v: Array[Dictionary]) -> Array[Resource]:
		var _players: Array[Resource]
		for i in v:
			_players.append(load(i.filepath))
		return _players

var classes: Classes
