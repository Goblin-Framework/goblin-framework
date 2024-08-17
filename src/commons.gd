class_name Commons

static var parameter_required = 'Parameter value is required!'
static var groupname_required = 'Groupname value is required!'
static var parameter_invalid  = 'Invalid value of the parameter!'
static var orthogonal_projection_required = 'Projection is required to be set as Orthogonal!'

static func check_typeof(value: Variant) -> String:
	if typeof(value) == TYPE_FLOAT:
		return 'float'
	elif typeof(value) == TYPE_INT:
		return 'int'
	return 'str'
