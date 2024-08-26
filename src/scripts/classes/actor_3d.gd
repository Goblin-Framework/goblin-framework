class_name Actor3DClass

## Variable reference for node [CharacterBody3D]
var _actor: CharacterBody3D

## Set the variable reference [CharacterBody3D]
func set_actor(node: CharacterBody3D) -> void:
	_actor = node

## Return the variable reference [CharacterBody3D]
func get_actor() -> CharacterBody3D:
	return _actor

## Variable reference for delta value, used for _physics_process
var _delta: float

## Set the variable reference for delta value
func set_delta(value: float) -> void:
	_delta = value

## Return the delta value
func get_delta() -> float:
	return _delta

## Variable reference for velocity [CharacterBody3D] that will be used for _physics_process
var _velocity: Vector3

## Set the variable reference for velocity
func set_velocity(value: Vector3) -> void:
	_velocity = value

## Return the variable reference velocity
func get_velocity() -> Vector3:
	return _velocity

## Variable reference for direction [CharacterBody3D] when moving
var _direction: Vector3

## Set the variable reference for direction
func set_direction(value: Vector3) -> void:
	_direction = value

## Return the variable reference for direction
func get_direction() -> Vector3:
	return _direction

## Variable reference for angular velocity of the [CharacterBody3D] when rotating
var _angular: float

## Set the variable angular [CharacterBody3D]
func set_angular(value: float) -> void:
	_angular = value

## Return the angular value
func get_angular() -> float:
	return _angular

## Variable reference for maximum current speed of the [CharacterBody3D] when moving
var _speed: float

## Set the variable reference speed [CharacterBody3D]
func set_speed(value: float) -> void:
	_speed = value

## Return the speed value
func get_speed() -> float:
	return _speed

## Variable reference for physics process status
var _physics: bool = true

## A method to enable/activate physics process
func enable_physics() -> void:
	_physics = true
	get_actor().set_physics_process(_physics)

## A method to disable/deactivate physics process
func disable_physics() -> void:
	_physics = false
	get_actor().set_physics_process(_physics)

## Return the variable reference physics
func get_physics() -> bool:
	return _physics

## Variable reference for acceleration velocity
var _acceleration: float

## Set the variable reference for acceleration
func set_acceleration(value: float):
	_acceleration = value

## Return the value acceleration
func get_acceleration() -> float:
	return _acceleration

## Variable reference for de-acceleration velocity
var _deacceleration: float

## Set the variable reference for dea-cceleration
func set_deacceleration(value: float):
	_deacceleration = value

## Return the value de-acceleration
func get_deacceleration() -> float:
	return _deacceleration

## Variable reference for gravity velocity
var _gravity: float

## Set the variable reference for gravity velocity
func set_gravity(value: float):
	_gravity = value

## Return the value gravitational force value
func get_gravitational_force() -> float:
	return _gravity * get_delta()

## Variable reference for pivot axis in Y point
var _pivot_y: float

## Set the variable reference for pivot axis Y
func set_pivot_y(value: float):
	_pivot_y = value

## Return the value pivot axis Y
func get_pivot_y() -> float:
	return _pivot_y
