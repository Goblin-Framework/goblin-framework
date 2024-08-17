class_name Actor3DBasePhysics

var _actor: CharacterBody3D
var _delta: float
var _physics_run := true

## Method constructor for [Actor3DBasePhysics]
func _init(node: CharacterBody3D):
	_actor = node

## Set the 'delta' value from _physics_process 
func set_delta(value: float) -> void:
	_delta = value

## Method to set the physics process of the actor as inactive
func disable_physics() -> void:
	_physics_run = false
	_actor.set_physics_process(_physics_run)

## Method to set the physics process of the actor as active
func enable_physics() -> void:
	_physics_run = true
	_actor.set_physics_process(_physics_run)

## Return the physics status active or deactive
func get_physics_status() -> bool:
	return _physics_run

## Return the actor node
func get_actor() -> CharacterBody3D:
	return _actor

## Return the calculated rotation toward actor direction movement
func get_rotation_toward_direction() -> float:
	return lerp_angle(
		_actor.pivot.rotation.y,
		atan2(_actor.dir.x, _actor.dir.z),
		_actor.angular_acceleration * _delta
	)

## Return the calculated interpolated velocity
func get_velocity_interpolated() -> Vector3:
	var normalized = _actor.dir.normalized()
	var hvel = normalized
	hvel.y = 0

	var course = normalized * _actor.max_speed
	var accel  = _actor.velocity_acceleration if normalized.dot(hvel) > 0 else _actor.velocity_deacceleration
	return hvel.lerp(course, accel * _delta)

## Return the calculated gravitational force
func get_gravity_force() -> float:
	return _actor.get_gravity() * _delta
