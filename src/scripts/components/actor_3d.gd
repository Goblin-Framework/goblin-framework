extends CharacterBody3D
class_name Actor3DComponent

## Signal to trigger disable/deactivate physics_process
signal disable_physics
## Signal to trigger enable/activate physics_process
signal enable_physics

## Variable group name for the node [Actor3DComponent]
@export var groupname: String = 'actor'
## Variable to set Pivot/Mesh for [Actor3DComponent]
@export var pivot_mesh_node: NodePath

@export_category('Physics')
## Angular acceleration value when [Actor3DComponent] is rotating
@export_range(1, 20) var angular_acceleration: float = 4.5
## Acceleration increase when [Actor3DComponent] is starting going to move
@export_range(1, 100) var velocity_acceleration: float = 16.0
## De-Acceleration increase when [Actor3DComponent] is starting going to stop
@export_range(1, 100) var velocity_deacceleration: float = 9.0
## Maximum speed when [Actor3DComponent] is moving
@export_range(1, 100) var max_speed: float = 12.5

## Velocity variable references
var vel: Vector3
## Direction variable references
var dir: Vector3
# references variable [Actor3DComponent] pivot or mesh node
var pivot: Node3D

# references variable for physics class [Actor3DComponent]
var _physics: Physics

## Class for base component physics
class Physics extends Actor3DBasePhysics:
	func _init(node: Actor3DComponent):
		super(node)

## Set the references for signal, method, object, and variable for component [Actor3DComponent]
func set_actor_component(node: Actor3DComponent) -> void:
	# Checking the groupname whether is empty or else and then adding to group if the nodes is not in group
	assert(not groupname.is_empty() or groupname != '', 'Actor node must be set for groupname')
	
	if not is_in_group(groupname):
		add_to_group(groupname)
	
	pivot = get_node(pivot_mesh_node)
	_physics = Physics.new(node)
	
	# connecting event for disable/enable physics.
	disable_physics.connect(_physics.disable_physics)
	enable_physics.connect(_physics.enable_physics)

## Return the gravity value from the settings
func get_gravity():
	return ProjectSettings.get_setting('physics/3d/default_gravity')

