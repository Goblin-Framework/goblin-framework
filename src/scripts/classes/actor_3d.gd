extends PersistClass
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

var _face: Node3D

func set_face(node: Node3D) -> void:
	_face = node

func get_face() -> Node3D:
	return _face

## Set the variable reference for pivot axis Y
func set_face_rotation(value: float):
	get_face().rotation.y = value

## Return the value pivot axis Y
func get_face_rotation() -> float:
	return get_face().rotation.y

## Variable reference for health point for [CharacterBody3D]
var _health_point: int

## Set the variable reference for health point of the [CharacterBody3D]
func set_health_point(value: int) -> void:
	_health_point = value

## Returnt the health point value of the [CharacterBody3D]
func get_health_point() -> int:
	return _health_point

## Variable reference for force point for [CharacterBody3D]
var _force_point: int

## Set the variable reference for force point of the [CharacterBody3D]
func set_force_point(value: int) -> void:
	_force_point = value

## Returnt the force point value of the [CharacterBody3D]
func get_force_point() -> int:
	return _force_point

## Variable reference for stamina point for [CharacterBody3D]
var _stamina_point: int

## Set the variable reference for stamina point of the [CharacterBody3D]
func set_stamina_point(value: int) -> void:
	_stamina_point = value

## Returnt the stamina point value of the [CharacterBody3D]
func get_stamina_point() -> int:
	return _stamina_point
