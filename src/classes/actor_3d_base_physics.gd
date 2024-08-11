class_name Actor3DBasePhysics

var _actor: CharacterBody3D
var _delta: float
var _physics_run := true

func _init(node: CharacterBody3D):
	_actor = node

## Set the 'delta' value from _physics_process 
func set_delta(value: float) -> void:
	_delta = value

func disable_physics() -> void:
	_physics_run = false
	_actor.set_physics_process(_physics_run)

func enable_physics() -> void:
	_physics_run = true
	_actor.set_physics_process(_physics_run)

func get_physics_status() -> bool:
	return _physics_run

func get_actor() -> CharacterBody3D:
	return _actor

func get_rotation_toward_direction() -> float:
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
