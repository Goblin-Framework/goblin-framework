extends CharacterBody3D
class_name Actor3D

## Signal to trigger when navigation is interacting to
signal navigation_interact_to(value: Dictionary)
## Signal when navigation is targeted/marked
signal navigation_marked
## Signal when navigation is leave/un-marked
signal navigation_unmarked
## Signal to trigger disable/deactivate physics_process
signal disable_physics
## Signal to trigger enable/activate physics_process
signal enable_physics

## Variable group name for the node [Actor3D]
@export var groupname: String = 'actor'
## Variable to set Pivot/Mesh for [Actor3D]
@export var face_node: NodePath
@export var universal_action_key_input: String = 'universal_action'

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

## Class main physics for [Actor3D] for the basic physics and process in actor
class Physics extends Actor3DPhysics:
	func _init(n: Actor3D) -> void:
		set_actor(n)
	
	## Set the velocity processing of the [Actor3D] if physics status is enable
	func set_velocity_process(v: Vector3) -> void:
		if get_physics():
			set_velocity(v)
			get_actor().velocity = get_velocity()

## Class utilities for [Actor3D] that use movement based on navigation path finding
class Navigation extends Physics:
	var _actor_targeted: Actor3D
	var _actor_target: CharacterBody3D
	
	func _init(n: Actor3D) -> void:
		super(n)
	
	## A method when condition navigation is set to the [Actor3D] target
	func navigated_to_actor(c: Actor3D) -> void:
		# Check if instance id is not same then it's should be proceed to navigate
		if c.get_instance_id() != get_actor().get_instance_id():
			_actor_targeted = c
			
			# Check if face has signal to activate the interaction
			if get_face().has_signal('enable_interaction'):
				get_face().emit_signal('enable_interaction', _actor_target.get_instance_id())
	
	## Global navigation to target either is collision or [Actor3D]
	func navigation_to_target(d: Dictionary) -> void:
		if not d.is_empty() and get_physics():
			var c = d.collider
			
			if c.get_class() == 'Actor3D':
				navigated_to_actor(c)
			
			if _actor_target != null and _actor_target.has_signal('navigation_unmarked'):
				_actor_target.emit_signal('navigation_unmarked')
			
			get_navigation_agent().set_target_position(d.position)

## Variable physics object class
var physics: Physics
## Variable navigation object class
var navigation: Navigation
