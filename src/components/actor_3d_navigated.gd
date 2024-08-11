extends CharacterBody3D
class_name Actor3DNavigatedComponent

signal receive_pointing_camera_information(value: Dictionary)

@export_category('Debug')
@export var is_debug := true

var _navigation_agent_3d := NavigationAgent3D.new()
var _velocity := Vector3.ZERO
var _direction: Vector3

class PathFinding extends Actor3DProcessing:
	func _init(node: Actor3DNavigatedComponent):
		super(node)
		set_navigation_agent(node.get_navigation_agent())
	
	func on_velocity_set(value: Vector3) -> void:
		if get_physics_status():
			get_actor().velocity = value
	
	func on_receive_pointing_camera_information(value: Dictionary) -> void:
		if not value.is_empty() and get_physics_status():
			if value.collider.get_class() == 'CharacterBody3D':
				if value.collider.get_instance_id() != get_instance_id():
					pass
#					get_actor().get_navigation_agent().set_target_position()
			else:
				get_actor().get_navigation_agent().set_target_position(value.position)

var path_finding: PathFinding

func get_navigation_agent() -> NavigationAgent3D:
	return _navigation_agent_3d

func init_navigation_agent() -> void:
	_navigation_agent_3d.avoidance_enabled = true
	_navigation_agent_3d.radius = .25
	_navigation_agent_3d.path_desired_distance = .1
	_navigation_agent_3d.target_desired_distance = .01
	_navigation_agent_3d.debug_enabled = is_debug
	_navigation_agent_3d.velocity_computed.connect(path_finding.on_velocity_set)
	call_deferred('add_child', _navigation_agent_3d)
	
	receive_pointing_camera_information.connect(path_finding.on_receive_pointing_camera_information)

func set_navigated_movement_physics_process(delta: float) -> void:
	path_finding.set_delta(delta)
	
	if not is_on_floor():
		_velocity.y -= path_finding.get_gravity_force()
	
	path_finding.set_velocity(_velocity)
	
	if get_navigation_agent().is_navigation_finished():
		velocity = Vector3.ZERO
		velocity.y = path_finding.get_velocity().y
	else:
		_direction = path_finding.get_course_distance()
		_velocity  = path_finding.get_velocity_by_navigation()
		
		if get_navigation_agent().avoidance_enabled:
			_navigation_agent_3d.set_velocity(_velocity)
		else:
			path_finding.on_velocity_set(_velocity)

func get_direction() -> Vector3:
	return _direction

## Get the [Vector3] value of velocity
func get_velocity() -> Vector3:
	return _velocity

