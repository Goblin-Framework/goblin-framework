extends Actor3D
class_name Actor3DTemplate

## Constructor method for [Actor3D] object
func construct_actor(o: Physics) -> void:
	# Checking the groupname whether is empty or else and then adding to group if the nodes is not in group
	assert(not groupname.is_empty() or groupname != '', Commons.ACTOR3D_GROUPNAME_REQUIRED)
	
	if not is_in_group(groupname):
		add_to_group(groupname)
	
	# Fill the variable references for the actor such as acceleration, angular, speed, and etc.
	o.set_acceleration(acceleration)
	o.set_deacceleration(deacceleration)
	o.set_angular(angular)
	o.set_speed(speed)
	o.set_face(get_node(face_node))
	o.set_direction(Vector3.ZERO)
	o.set_velocity(Vector3.ZERO)
	o.set_health_point(health_point)
	o.set_force_point(force_point)
	o.set_stamina_point(stamina_point)
	o.set_gravity(ProjectSettings.get("physics/3d/default_gravity"))

## construct with path finding [Actor3D] when enter tree
func construct_actor_path_finding_enter_tree(o: Navigation) -> void:
	construct_actor(o)

## Physics process for [Actor3D] object
func physics_process_actor(d: float, o: Physics) -> void:
	var vel = o.get_velocity()
	o.set_delta(d)
	
	if !is_on_floor():
		vel.y -= o.get_gravitational_force()
		o.set_velocity(vel)

## Physics process for [Actor3D] with path finding
func physics_process_actor_path_finding(d: float, o: Navigation) -> void:
	physics_process_actor(d, o)
	
	if o.get_navigation_agent().is_navigation_finished():
		velocity = Vector3.ZERO
		velocity.y = o.get_velocity().y
	
	else:
		o.set_direction(o.get_navigation_distance())
		o.navigated_velocity(.1)
		o.set_face_rotation(o.get_rotation_toward_direction())
		
		if o.get_navigation_agent().avoidance_enabled:
			o.get_navigation_agent().set_velocity(o.get_velocity())
		else:
			o.set_velocity_process(o.get_velocity())
