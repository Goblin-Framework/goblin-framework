extends CharacterBody3D
class_name Actor3D

signal receive_ray_information(value: Dictionary)

@export_category('Node Control')
## Pivot of [Actor3D] or mesh if leave blank then it will be parent node
@export var pivot_actor: NodePath

@export_category('Physics')
## Angular acceleration value when [Actor3D] is rotating
@export_range(1, 20) var angular_acceleration: float = 4.5
## Acceleration increase when [Actor3D] is starting going to move
@export_range(1, 100) var velocity_acceleration: float = 16.0
## De-Acceleration increase when [Actor3D] is starting going to stop
@export_range(1, 100) var velocity_deacceleration: float = 9.0
## Maximum speed when [Actor3D] is moving
@export_range(1, 100) var max_speed: float = 12.5

@export_category('Actor Play Control')
## When [Actor3D] gameplay is controlled by navigated with cursor
@export var is_navigated_with_cursor: bool = true

var _dump_velocity := Vector3.ZERO
var _navigation_agent_3d := NavigationAgent3D.new()
var _direction: Vector3
var _gravity := ProjectSettings.get_setting('physics/3d/default_gravity')
var _navigated_path: NavigatedPath
var _point_y_rotation: float
var _pivot_actor: Node3D

class Physics:
	var _actor: Actor3D
	var _delta: float
	
	func _init(target: Actor3D):
		_actor = target
	
	func set_delta(value: float) -> void:
		_delta = value
	
	func get_pivot_rotation_toward_direction() -> float:
		return lerp_angle(
			_actor.get_point_rotation_y(),
			atan2(_actor.get_direction().x, _actor.get_direction().z),
			_actor.angular_acceleration
		)
	
	func get_velocity_interpolated() -> Vector3:
		var normalized = _actor.get_direction().normalized()
		var hvel = normalized
		hvel.y = 0
	
		var course = normalized * _actor.max_speed
		var accel  = _actor.velocity_acceleration if normalized.dot(hvel) > 0 else _actor.velocity_deacceleration
		return hvel.lerp(course, accel * _delta)
	
	func get_gravity_force() -> float:
		return _actor.get_gravity() * _delta
		

class NavigatedPath extends Physics:
	var _velocity: Vector3
	var _navigation_agent: NavigationAgent3D
	
	func _init(target: Actor3D, navigation_agent):
		super(target)
		_navigation_agent = navigation_agent
	
	func get_course_distance() -> Vector3:
		return _navigation_agent.get_next_path_position() - _actor.global_position
	
	func set_velocity(value: Vector3) -> void:
		_velocity = value
	
	func get_velocity() -> Vector3:
		return _velocity
	
	func get_velocity_by_navigation() -> Vector3:
		var tmp_velocity = get_velocity_interpolated()
		_velocity.z = tmp_velocity.z
		_velocity.x = tmp_velocity.x
		
		if _actor.get_direction().y > .1:
			_velocity.y = tmp_velocity.y - get_gravity_force()
		
		return _velocity

# Called when the node enters the scene tree for the first time.
func _ready():
	_pivot_actor = get_node(pivot_actor) if not pivot_actor.is_empty() else get_parent()
	_point_y_rotation = _pivot_actor.rotation.y
	
	if is_navigated_with_cursor:
		_set_navigation_agent_to_character(_navigation_agent_3d)
		_navigated_path = NavigatedPath.new($'.', _navigation_agent_3d)
		receive_ray_information.connect(on_receive_ray_information)

func _set_navigation_agent_to_character(navigation_agent: NavigationAgent3D) -> void:
	navigation_agent.avoidance_enabled = true
	navigation_agent.radius = .25
	navigation_agent.path_desired_distance = .1
	navigation_agent.target_desired_distance = .01
	navigation_agent.velocity_computed.connect(on_navigation_veloicity_set)
	add_child(navigation_agent)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if is_navigated_with_cursor:
		_navigated_path_physics_process(delta)
	move_and_slide()

func _navigated_path_physics_process(delta) -> void:
	_navigated_path.set_delta(delta)
	
	if not is_on_floor():
		_dump_velocity.y -= _navigated_path.get_gravity_force()
	print(is_on_floor())
	
	_navigated_path.set_velocity(_dump_velocity)
	
	if _navigation_agent_3d.is_navigation_finished():
		velocity = Vector3.ZERO
		velocity.y = _navigated_path.get_velocity().y
	else:
		_direction = _navigated_path.get_course_distance()
		_dump_velocity = _navigated_path.get_velocity_by_navigation()
		
		if _navigation_agent_3d.avoidance_enabled:
			_navigation_agent_3d.set_velocity(_dump_velocity)
		else:
			on_navigation_veloicity_set(_dump_velocity)

## Method signal when [NavigationAgent3D] in [Actor3D] velocity is override
func on_navigation_veloicity_set(value: Vector3) -> void:
	velocity = value

## Method signal when [Actor3D] is receiving ray information from camera
func on_receive_ray_information(value: Dictionary) -> void:
	if not value.is_empty():
		_navigation_agent_3d.set_target_position(value.position)

## Get the object of [NavigationAgent3D]
func get_navigation_agent() -> NavigationAgent3D:
	return _navigation_agent_3d

## Get the [Vector3] value of direction
func get_direction() -> Vector3:
	return _direction

## Get the gravitation value
func get_gravity() -> float:
	return _gravity

## Get the [Vector3] value of velocity
func get_velocity() -> Vector3:
	return _dump_velocity

## Get the value of the point rotation of Y from pivot
func get_point_rotation_y() -> float:
	return _point_y_rotation
