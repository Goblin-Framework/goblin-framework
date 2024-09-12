class_name Common
#TODO: tambahkan comment dokumentasi pada method disini

class Exception:
	const SIGNAL_NOT_FOUND = 'Fatal Error! Signal not found'
	const PATH_NOT_FOUND   = 'Fatal Error! Path resource not found'
	const METHOD_NOT_FOUND = 'Fatal Error! Method not found'
	
	var message: String
	
	func _init(m: String) -> void:
		message = m
	
	static func signal_not_found(s: String, n: Node) -> String:
		var e = Exception.new('%s: %s-%s' % [Exception.SIGNAL_NOT_FOUND,s, n.name])
		return e.message
	
	static func path_not_found(p: String) -> String:
		var e = Exception.new('%s: %s' % [Exception.PATH_NOT_FOUND, p])
		return e.message
		
	static func method_not_found(n: Node) -> String:
		var e = Exception.new('%s: %s' % [Exception.PATH_NOT_FOUND, n.name])
		return e.message
