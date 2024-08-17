extends Actor3DComponent
class_name Actor3DNavPathComponent

signal receive_pointing_camera_information(value: Dictionary)

## Radius avoidance collision path navigation
@export var debug := true
@export_range(1, 5) var radius: float:
	get:
		return radius * .25

var _navigation_agent_3d: NavigationAgent3D = NavigationAgent3D.new()
var _path_finding: PathFinding

class PathFinding extends Actor3DProcessor:
	func _init(node: Actor3DNavPathComponent):
		super(node)
	
	## Event/Signal method to set the velocity actor
	func on_velocity_set(value: Vector3) -> void:
		if get_physics_status():
			get_actor().velocity = value
	
	## Event/Signal method to get the information pointing from ray query [Camera3D]
	func on_receive_pointing_camera_information(value: Dictionary) -> void:
		if not value.is_empty() and get_physics_status():
			if value.collider.get_class() == 'CharacterBody3D':
				if value.collider.get_instance_id() != get_instance_id():
					pass
#					get_actor().get_navigation_agent().set_target_position()
			else:
				get_actor().get_navigation_agent().set_target_position(value.position)

func set_actor_navpath_component(node: Actor3DNavPathComponent) -> void:
	set_actor_component(node)
	_navigation_agent_3d.avoidance_enabled = true
	_navigation_agent_3d.radius = radius
	_navigation_agent_3d.path_desired_distance = .1
	_navigation_agent_3d.target_desired_distance = .01
	_navigation_agent_3d.debug_enabled = debug
	
	_path_finding = PathFinding.new(node)
	
	_navigation_agent_3d.velocity_computed.connect(_path_finding.on_velocity_set)
	_path_finding.set_navigation_agent(_navigation_agent_3d)
	
	call_deferred('add_child', _navigation_agent_3d)
	
	receive_pointing_camera_information.connect(_path_finding.on_receive_pointing_camera_information)

func set_actor_navpath_physics_process(delta: float) -> void:
	_path_finding.set_delta(delta)
	
	if not is_on_floor():
		vel.y -= _path_finding.get_gravity_force()
	
	if _navigation_agent_3d.is_navigation_finished():
		velocity = Vector3.ZERO
		velocity.y = _path_finding.get_velocity().y
		
	else:
		dir = _path_finding.get_course_distance()
		vel = _path_finding.get_velocity_by_navigation()
		pivot.rotation.y = _path_finding.get_rotation_toward_direction()
		
		if _navigation_agent_3d.avoidance_enabled:
			_navigation_agent_3d.set_velocity(vel)
		else:
			_path_finding.on_velocity_set(vel)

func get_navigation_agent() -> NavigationAgent3D:
	return _navigation_agent_3d
