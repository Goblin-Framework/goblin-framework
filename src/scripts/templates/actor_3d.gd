extends Actor3D
class_name Actor3DTemplate

var _interaction: bool = false

## Constructor method for [Actor3D] object
func construct_actor_object(object: Base) -> void:
	# Checking the groupname whether is empty or else and then adding to group if the nodes is not in group
	assert(not groupname.is_empty() or groupname != '', Commons.actor_groupname_required)
	
	if not is_in_group(groupname):
		add_to_group(groupname)
	
	# Fill the variable references for the actor such as acceleration, angular, speed, and etc.
	object.set_acceleration(acceleration)
	object.set_deacceleration(deacceleration)
	object.set_angular(angular)
	object.set_speed(speed)
	object.set_face(get_node(face_node))
	object.set_direction(Vector3.ZERO)
	object.set_velocity(Vector3.ZERO)
	object.set_health_point(health_point)
	object.set_force_point(force_point)
	object.set_stamina_point(stamina_point)
	object.set_gravity(ProjectSettings.get("physics/3d/default_gravity"))

## Construct method for [Actor3D] with path finding
func construct_actor_path_finding(node: Actor3D) -> void:
	navigation = Navigation.new(node)
	construct_actor_object(navigation)
	receive_pointing_camera_information.connect(navigation.on_receive_pointing_camera_information)

## Physics process for [Actor3D] object
func physics_proces_actor_object(delta: float, object: Base) -> void:
	var vel = object.get_velocity()
	object.set_delta(delta)
	
	if !is_on_floor():
		vel.y -= object.get_gravitational_force()
		object.set_velocity(vel)

## Physics process for [Actor3D] with path finding
func physics_process_actor_path_finding(delta: float) -> void:
	physics_proces_actor_object(delta, navigation)
	
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

func enable_interaction() -> void:
	_interaction = true

func disable_interaction() -> void:
	_interaction = false

func get_interaction() -> bool:
	return _interaction
