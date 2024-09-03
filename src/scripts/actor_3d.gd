extends CharacterBody3D
class_name Actor3D

## Class utilities base for [Actor3D] for the basic physics and process in actor
class Base extends Actor3DPhysics:
	func _init(node: Actor3D):
		set_actor(node)
	
	## Set the velocity processing of the [Actor3D] if physics status is enable
	func set_velocity_process(value: Vector3) -> void:
		if get_physics():
			set_velocity(value)
			get_actor().velocity = get_velocity()

## Class utilities for [Actor3D] that use movement based on navigation path finding
class Navigation extends Base:
	func _init(node: Actor3D):
		super(node)
	
	func on_receive_pointing_camera_information(value: Dictionary) -> void:
		if not value.is_empty() and get_physics():
			if value.collider.get_class() == 'CharacterBody3D':
				if value.collider.get_instance_id() != get_instance_id():
					get_face().emit_signal('enable_interaction_casts')
					get_navigation_agent().set_target_position(value.position)
			
			else:
				get_navigation_agent().set_target_position(value.position)

var _face: Face3DComponent
var _target_id

## Signal to trigger when receiving pointing camera information in 3D space
signal receive_pointing_camera_information(value: Dictionary)
## Signal to trigger disable/deactivate physics_process
signal disable_physics
## Signal to trigger enable/activate physics_process
signal enable_physics

## Variable group name for the node [Actor3D]
@export var groupname: String = 'actor'
## Variable to set Pivot/Mesh for [Actor3D]
@export var face_node: NodePath

@export_subgroup('Health-Force-Stamina')
## Value of the health/life point of the [Actor3D]
@export var health_point: int = 100
## Value of the force/mana point of the [Actor3D]
@export var force_point: int = 100
## Value of the stamina/power point of the [Actor3D]
@export var stamina_point: int = 100

@export_category('Physics')
## Angular acceleration value when [Actor3DComponent] is rotating
@export_range(1, 20) var angular: float = 4.5
## Acceleration increase when [Actor3DComponent] is starting going to move
@export_range(1, 99) var acceleration: float = 16.0
## De-Acceleration increase when [Actor3DComponent] is starting going to stop
@export_range(1, 99) var deacceleration: float = 9.0
## Maximum speed when [Actor3DComponent] is moving
@export_range(1, 99) var speed: float = 12.5

## Variable base object class
var base: Base
## Variable navigation object class
var navigation: Navigation

## Main construct method for [Actor3D]
func construct_actor(object: Base) -> void:
	# Checking the groupname whether is empty or else and then adding to group if the nodes is not in group
	assert(not groupname.is_empty() or groupname != '', Commons.actor_groupname_required)
	
	if not is_in_group(groupname):
		add_to_group(groupname)
	
	object.set_acceleration(acceleration)
	object.set_deacceleration(deacceleration)
	object.set_angular(angular)
	object.set_speed(speed)
	object.set_face(get_node(face_node))
	object.set_direction(Vector3.ZERO)
	object.set_velocity(Vector3.ZERO)
	object.set_gravity(ProjectSettings.get("physics/3d/default_gravity"))
	
	enable_physics.connect(object.enable_physics)
	disable_physics.connect(object.disable_physics)

func construct_actor_only_base(node: Actor3D) -> void:
	base = Base.new(node)
	construct_actor(base)

func construct_actor_path_finding(node: Actor3D) -> void:
	navigation = Navigation.new(node)
	
	construct_actor(navigation)
	receive_pointing_camera_information.connect(navigation.on_receive_pointing_camera_information)

func physics_proces_actor_only_base(delta: float) -> void:
	var vel = base.get_velocity()
	base.set_delta(delta)
	
	if !is_on_floor():
		vel.y -= base.get_gravitational_force()
		base.set_velocity(vel)

func physics_process_actor_path_finding(delta: float) -> void:
	var vel = navigation.get_velocity()
	navigation.set_delta(delta)
	
	if !is_on_floor():
		vel.y -= navigation.get_gravitational_force()
		navigation.set_velocity(vel)
	
	if navigation.get_navigation_agent().is_navigation_finished():
		velocity = Vector3.ZERO
		velocity.y = navigation.get_velocity().y
	else:
		navigation.set_direction(navigation.get_navigation_distance())
		navigation.navigated_velocity(.1)
		navigation.set_face_rotation(navigation.get_rotation_toward_direction())
		
		if navigation.get_navigation_agent().avoidance_enabled:
			navigation.get_navigation_agent().set_velocity(navigation.get_velocity())
		else:
			navigation.set_velocity_process(navigation.get_velocity())

func component_set_navigation_agent(node: NavigationAgent3D) -> void:
	navigation.set_navigation_agent(node)

