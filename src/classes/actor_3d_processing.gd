extends Actor3DBasePhysics
class_name Actor3DProcessing

var _velocity: Vector3
var _navigation_agent: NavigationAgent3D

func _init(node: CharacterBody3D):
	super(node)

func get_course_distance() -> Vector3:
	return _navigation_agent.get_next_path_position() - _actor.global_position

func set_navigation_agent(node: NavigationAgent3D) -> void:
	_navigation_agent = node

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
