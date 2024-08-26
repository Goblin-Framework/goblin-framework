extends Actor3DProcessor
class_name Actor3DPhysics

## Return the calculated velocity [CharacterBody3D] by navigation path
func navigated_velocity(max_climb: float) -> void:
	var interpolated = get_velocity_interpolated()
	var velocity = get_velocity()
	
	velocity.z = interpolated.z
	velocity.x = interpolated.x
	
	if get_direction().y > max_climb:
		velocity.y = interpolated.y - get_gravitational_force()
	
	set_velocity(velocity)

