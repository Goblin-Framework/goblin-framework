extends DialogueClass
class_name DialogueProcessorClass

# Variable reference to filter the name as active
var _active_name: String

## Method to set the name as active placement label
func set_active_name(v: String) -> void:
	_active_name = v

## Method to parse the log string in the dialogue
func parse_log_string(v: String) -> Dictionary:
	var result = {'log': v}
	
	if v.contains(':'):
		var split: Array[String] = v.split(':')
		var lname: String = split[0].strip_edges()
		var ltext: String = split[1].strip_edges()
		
		result = {
			'log'   : ltext,
			'name'  : get_name()[lname],
			'active': bool(lname == _active_name)
		}
		
	return result

## Method to running the callables in the dialogue
func parse_callables(v: Array[Callable]) -> void:
	for i in v:
		i.call_deferred()
