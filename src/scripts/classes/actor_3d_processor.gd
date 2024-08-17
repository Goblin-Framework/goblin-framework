extends Actor3DBasePhysics
class_name Actor3DProcessor

var _velocity: Vector3
var _navigation_agent: NavigationAgent3D

## Method constructor for [Actor3DProcessor]
func _init(node: CharacterBody3D):
	super(node)

## Return the calculated course distance for navigated actor
func get_course_distance() -> Vector3:
	return _navigation_agent.get_next_path_position() - _actor.global_position

## Set the navigation agent 3D node
func set_navigation_agent(node: NavigationAgent3D) -> void:
	_navigation_agent = node

## Set the [Vector3] value of velocity actor
func set_velocity(value: Vector3) -> void:
	_velocity = value

## Return the [Vector3] value of velocity actor
func get_velocity() -> Vector3:
	return _velocity

## Return the calculated [Vector3] velocity actor by navigation path
func get_velocity_by_navigation() -> Vector3:
	var tmp_velocity = get_velocity_interpolated()
	_velocity.z = tmp_velocity.z
	_velocity.x = tmp_velocity.x
	
	if _actor.dir.y > .1:
		_velocity.y = tmp_velocity.y - get_gravity_force()
	
	return _velocity
