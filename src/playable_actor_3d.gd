extends Actor3DNavigatedComponent
class_name PlayableActor3D

signal disable_physics
signal enable_physics

## Groupname for flaging the nodes as using physics processing
@export var groupname_physics: String = 'actor'

@export_category('Components nodes')
## Pivot of [PlayableActor3D] or mesh if leave blank then it will be parent node
@export var pivot_actor: NodePath

@export_category('Physics')
## Angular acceleration value when [PlayableActor3D] is rotating
@export_range(1, 20) var angular_acceleration: float = 4.5
## Acceleration increase when [PlayableActor3D] is starting going to move
@export_range(1, 100) var velocity_acceleration: float = 16.0
## De-Acceleration increase when [PlayableActor3D] is starting going to stop
@export_range(1, 100) var velocity_deacceleration: float = 9.0
## Maximum speed when [PlayableActor3D] is moving
@export_range(1, 100) var max_speed: float = 12.5

var _pivot_actor: Node3D
var _point_y_rotation: float

# Called when the node enters the scene tree for the first time.
func _ready():
	# Checking the groupname whether is empty or else and then adding to group if the nodes is not in group
	assert(not groupname_physics.is_empty() or groupname_physics != '', 'Actor node must be set for groupname physics')
	
	if not is_in_group(groupname_physics):
		add_to_group(groupname_physics)
	
	_pivot_actor      = get_node(pivot_actor) if not pivot_actor.is_empty() else get_parent()
	_point_y_rotation = _pivot_actor.rotation.y
	
	path_finding = PathFinding.new($'.')
	
	enable_physics.connect(path_finding.enable_physics)
	disable_physics.connect(path_finding.disable_physics)
	
	init_navigation_agent()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	set_navigated_movement_physics_process(delta)
	move_and_slide()

func get_gravity():
	return ProjectSettings.get_setting('physics/3d/default_gravity')

## Get the value of the point rotation of Y from pivot
func get_point_rotation_y() -> float:
	return _point_y_rotation
