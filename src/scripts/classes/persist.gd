class_name PersistClass

## A simple constant to define the string of the persist groupname
const PERSIST = 'persist'

# Variable to define the node as persistence type to be read/save in state
var _persist:Node

## Set the node as persistence type to be load/save in state 
func set_persist(n: Node) -> void:
	_persist = n
	
	if not _persist.is_in_group(PERSIST):
		_persist.add_to_group(PERSIST)

## Return the node if is already in persistence or not
func get_persist_status() -> bool:
	return _persist.is_in_group(PERSIST) if _persist != null else false

# An abbreviation of Unique Identifier Node an custom unique name of the node
var _uidn: String

## Set the Unique Identifier Node to the variable
func set_uidn(v: String) -> void:
	_uidn = Marshalls.utf8_to_base64(v)

## Return the Unique Identifier Node from the variable
func get_uidn() -> String:
	return Marshalls.base64_to_utf8(_uidn)

# Variable reference to identify the input status is disabled/enabled
var _input_status: bool

## Method to set the input and unhandled input
func set_input_mode(v: bool) -> void:
	_persist.set_process_input(v)
	_persist.set_process_unhandled_input(v)
	_input_status = v
	
## Return the variable input status
func get_input_mode() -> bool:
	return _input_status

# Variable reference to identify the physics_process status is disabled/enabled
var _physics_status: bool

## Method to set the physics_process
func set_physics_mode(v: bool) -> void:
	_persist.set_physics_process(v)
	_physics_status = v

## Return the variable physics status
func get_physics_mode() -> bool:
	return _physics_status

# Variable reference to identify the process status is disabled/enabled
var _process_status: bool

## Method to set the process
func set_process_mode(v: bool) -> void:
	_persist.set_process(v)
	_process_status = v

## Return the variable process status
func get_process_mode() -> bool:
	return _process_status
