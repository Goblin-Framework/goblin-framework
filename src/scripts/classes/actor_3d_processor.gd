extends Actor3DClass
class_name Actor3DProcessor

## Variable reference for navigation agent 3D path
var _navigation_agent_3d: NavigationAgent3D

## Set the navigation agent 3D variable
func set_navigation_agent(node: NavigationAgent3D) -> void:
	_navigation_agent_3d = node

## Return the node navigation agent 3D
func get_navigation_agent() -> NavigationAgent3D:
	return _navigation_agent_3d

## Return the calculated navigation distance for [CharacterBody3D]
func get_navigation_distance() -> Vector3:
	return get_navigation_agent().get_next_path_position() - get_actor().global_position

## Return the calculated rotation toward [CharacterBody3D] direction movement
func get_rotation_toward_direction() -> float:
	return lerp_angle(
		get_face_rotation(),
		atan2(get_direction().x, get_direction().z),
		get_angular() * get_delta()
	)

## Return the calculated interpolated velocity
func get_velocity_interpolated() -> Vector3:
	var normalized = get_direction().normalized()
	var hvel = normalized
	hvel.y = 0

	var course = normalized * get_speed()
	var accel  = get_acceleration() if normalized.dot(hvel) > 0 else get_deacceleration()
	return hvel.lerp(course, accel * get_delta())

var _is_dead: bool

func health_point_updated(value: int) -> void:
	set_health_point(get_health_point() + value)
	_is_dead = bool(get_health_point() > 1)

func get_is_dead() -> bool:
	return _is_dead

var _is_forceless: bool

func force_point_updated(value: int) -> void:
	set_force_point(get_force_point() + value)
	_is_forceless = bool(get_force_point() > 1)

func get_is_forceless() -> bool:
	return _is_forceless

var _is_fatigue: bool

func stamina_point_updated(value: int) -> void:
	set_stamina_point(get_stamina_point() + value)
	_is_fatigue = bool(get_stamina_point() > 1)

func get_is_fatigue() -> bool:
	return _is_fatigue
