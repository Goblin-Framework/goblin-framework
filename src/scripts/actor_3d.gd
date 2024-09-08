extends CharacterBody3D
class_name Actor3D

## Class utilities base for [Actor3D] for the basic physics and process in actor
class Base extends Actor3DPhysics:
	func _init(node: Actor3D) -> void:
		set_actor(node)
	
	## Set the velocity processing of the [Actor3D] if physics status is enable
	func set_velocity_process(value: Vector3) -> void:
		if get_physics():
			set_velocity(value)
			get_actor().velocity = get_velocity()
	
	func get_randomize_greetings() -> String:
		var i = randi_range(0, get_actor().greetings.size() - 1)
		return get_actor().greetings[i]

## Class utilities for [Actor3D] that use movement based on navigation path finding
class Navigation extends Base:
	var _actor_target: CharacterBody3D
	
	func _init(node: Actor3D) -> void:
		super(node)
	
	func on_receive_pointing_camera_information(value: Dictionary) -> void:
		if not value.is_empty() and get_physics():
			var collide_with = value.collider
			
			if collide_with.get_class() == 'CharacterBody3D' and collide_with.get_instance_id() != get_actor().get_instance_id():
				_actor_target = collide_with
				print(_actor_target)
				
				if get_face().has_signal('enable_interaction_casts'):
					get_face().emit_signal('enable_interaction_casts', value.collider.get_instance_id())
					
			if _actor_target != null and _actor_target.has_signal('off_casts_target'):
				_actor_target.emit_signal('off_casts_target')
				
			get_navigation_agent().set_target_position(value.position)

var _face: Face3DComponent
var _target_id

## Signal to trigger when receiving pointing camera information in 3D space
signal receive_pointing_camera_information(value: Dictionary)
## Signal to trigger disable/deactivate physics_process
signal disable_physics
## Signal to trigger enable/activate physics_process
signal enable_physics
## Signal to trigger when the actor is hitted with the interaction casts hit or not
signal interaction_casts_hit
## Signal to turning off all the casts that been hitted with
signal off_casts_target

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

## Variable base object class
var base: Base
## Variable navigation object class
var navigation: Navigation
