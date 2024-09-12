class_name Commons
#TODO: migrasikan constant dari sini ke Commons.Exception

const LEVEL_GROUPNAME_REQUIRED     = 'Error groupname for node Level! Groupname is required'
const STAGE_GROUPNAME_REQUIRED     = 'Error groupname for node Stage! Groupname is required'
const CAMVIEW3D_GROUPNAME_REQUIRED = 'Error groupname for node CamView3D! Groupname is required'
const ACTOR3D_GROUPNAME_REQUIRED   = 'Error groupname for node Actor3D! Groupname is required'

const STAGE3D_SIGNAL_DROP_STAGE_NOT_FOUND  = 'Error signal "drop_stage" not found in Stage3D'
const STAGE3D_SIGNAL_BUILD_STAGE_NOT_FOUND = 'Error signal "build_stage" not found in Stage3D'

static var actor_groupname_required     = 'Parameter groupname for Actor node is required'
static var camview_groupname_required   = 'Parameter groupname for Camview node is required'
static var inventory_groupname_required = 'Parameter groupname for Inventory node is required'
static var item_groupname_required      = 'Parameter groupname for Item node is required'


static func check_typeof(value: Variant) -> String:
	if typeof(value) == TYPE_FLOAT:
		return 'float'
	elif typeof(value) == TYPE_INT:
		return 'int'
	return 'str'
