class_name PersistClass

## Variable reference for set the [Node3D] as persists for save state
var _persist:bool

## Set the variable reference for the persists save state for [Node3D]
func set_persist(v: bool, n: Node) -> void:
	_persist = v
	
	if _persist and not n.is_in_group('persist'):
		n.add_to_group('persist')

## Return the persists save state for [Node3D]
func get_persist() -> bool:
	return _persist

## Variable for unique key for the object that using persistence
var _unique_name: String

func set_unique_name(v: String) -> void:
	_unique_name = v

func get_unique_name() -> String:
	return _unique_name
