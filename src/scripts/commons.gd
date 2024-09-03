class_name Commons

static var actor_groupname_required = 'Parameter groupname for Actor node is required'
static var camview_groupname_required = 'Parameter groupname for Camview node is required'

static func check_typeof(value: Variant) -> String:
	if typeof(value) == TYPE_FLOAT:
		return 'float'
	elif typeof(value) == TYPE_INT:
		return 'int'
	return 'str'
