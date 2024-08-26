extends Actor3DComponent
class_name Actor3DNavigatedComponent

signal receive_pointing_camera_information(value: Dictionary)

## Variable for debug purpose in [NavigationAgent3D]
@export var debug := true
## Radius avoidance collision path navigation
@export_range(1, 5) var radius: float:
	get:
		return radius * .25

var _path_finding: PathFinding

## An object class for navigation to finding path for actor
class PathFinding extends Physics:
	func _init(node: Actor3DNavigatedComponent):
		super(node)
	
	## Event/Signal method to set the velocity actor
	func on_velocity_set(value: Vector3) -> void:
		if get_physics():
			set_velocity(value)
			get_actor().velocity = get_velocity()
	
	## Event/Signal method to get the information pointing from ray query [Camera3D]
	func on_receive_pointing_camera_information(value: Dictionary) -> void:
		if not value.is_empty() and get_physics():
			if value.collider.get_class() == 'CharacterBody3D':
				if value.collider.get_instance_id() != get_instance_id():
					pass
#					get_actor().get_navigation_agent().set_target_position()
			else:
				get_navigation_agent().set_target_position(value.position)

func default_navigation_agent() -> void:
	var navigation_agent = NavigationAgent3D.new()
	navigation_agent.avoidance_enabled = true
	navigation_agent.radius = radius
	navigation_agent.path_desired_distance = .1
	navigation_agent.target_desired_distance = .01
	navigation_agent.debug_enabled = debug
	navigation_agent.velocity_computed.connect(_path_finding.on_velocity_set)
	
	_path_finding.set_navigation_agent(navigation_agent)
	
	call_deferred('add_child', _path_finding.get_navigation_agent())

func setup_actor_navigated(node: Actor3DNavigatedComponent) -> void:
	_path_finding = PathFinding.new(node)
	
	setup_actor_base(node, _path_finding)
	default_navigation_agent()
	
	receive_pointing_camera_information.connect(_path_finding.on_receive_pointing_camera_information)

func physics_process_actor_navigated(delta: float) -> void:
	var vel = _path_finding.get_velocity()
	_path_finding.set_delta(delta)
	
	if !is_on_floor():
		vel.y -= _path_finding.get_gravitational_force()
		_path_finding.set_velocity(vel)
	
	if _path_finding.get_navigation_agent().is_navigation_finished():
		velocity = Vector3.ZERO
		velocity.y = _path_finding.get_velocity().y
	else:
		_path_finding.set_direction(_path_finding.get_navigation_distance())
		_path_finding.navigated_velocity(.1)
		_path_finding.set_pivot_y(_path_finding.get_rotation_toward_direction())
		_pivot.rotation.y = _path_finding.get_pivot_y()
		
		if _path_finding.get_navigation_agent().avoidance_enabled:
			_path_finding.get_navigation_agent().set_velocity(_path_finding.get_velocity())
		else:
			_path_finding.on_velocity_set(_path_finding.get_velocity())
