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
@export_range(1, 20) var angular: float = 4.5
## Acceleration increase when [Actor3DComponent] is starting going to move
@export_range(1, 100) var acceleration: float = 16.0
## De-Acceleration increase when [Actor3DComponent] is starting going to stop
@export_range(1, 100) var deacceleration: float = 9.0
## Maximum speed when [Actor3DComponent] is moving
@export_range(1, 100) var speed: float = 12.5

## Velocity variable references
var vel: Vector3
## Direction variable references
var dir: Vector3
# references variable [Actor3DComponent] pivot or mesh node
var pivot: Node3D

# references variable for physics class [Actor3DComponent]
var _physics: Physics

var _pivot: Node3D

## Class for base component physics
class Physics extends Actor3DPhysics:
	func _init(node: Actor3DComponent):
		set_actor(node)

func setup_actor_base(node: Actor3DComponent, object: Physics) -> void:
	# Checking the groupname whether is empty or else and then adding to group if the nodes is not in group
	assert(not groupname.is_empty() or groupname != '', 'Camera3D node must be set for groupname')
	
	if not is_in_group(groupname):
		add_to_group(groupname)
	
	_pivot = get_node(pivot_mesh_node)
	
	object.set_acceleration(acceleration)
	object.set_deacceleration(deacceleration)
	object.set_angular(angular)
	object.set_speed(speed)
	object.set_pivot_y(_pivot.rotation.y)
	object.set_direction(Vector3.ZERO)
	object.set_velocity(Vector3.ZERO)
	object.set_gravity(ProjectSettings.get("physics/3d/default_gravity"))
	
	enable_physics.connect(object.enable_physics)
	disable_physics.connect(object.disable_physics)
