extends Node3D
class_name Face3DComponent

var _target: Vector3 = Vector3.ZERO
var _offset: Array[RayCast3D]
var _actor: Actor3D

signal enable_interaction_casts
signal disable_interaction_casts

@export_range(1, 45) var radius: float = 30.0
@export_range(1, 99) var max_raycasts: int = 5
@export_range(1, 5) var cast_z: float = 2
@export var mirror: bool = true
@export var area_collision: bool = false
@export var cast_always_enable: bool = false

func _ready():
	_actor = get_parent()
	_target.z = cast_z
	
	construct_interaction_casts()
	
	if not cast_always_enable:
		enable_interaction_casts.connect(_on_enable_interaction_casts)
		disable_interaction_casts.connect(_on_disable_interaction_casts)

func _physics_process(delta):
	for i in get_list_ray_casts():
		if i.is_colliding():
			var collider = i.get_collider()
			if _actor.navigation != null:
				_actor.navigation.get_navigation_agent().target_position = collider.position

## Instantiate a new [RayCast3D] with it's requirements
func ray_cast(rotate: float, mask: int) -> RayCast3D:
	var rc = RayCast3D.new()
	
	rc.rotation.y = rotate
	rc.collide_with_areas = area_collision
	rc.enabled = cast_always_enable
	rc.target_position = _target
	rc.set_collision_mask(mask)
	
	return rc

## Set lists offset [RayCast3D] based on distribution radius
func set_lists_offset_ray_casts(offset: int, dist: float) -> void:
	var deg_dist = dist
	
	for i in range(offset):
		# positive ray cast offset
		var rc = ray_cast(deg_to_rad(deg_dist), _actor.get_collision_layer())
		# negative ray cast offset (mirror)
		var rcm = ray_cast(-deg_to_rad(deg_dist), _actor.get_collision_layer())
		
		# will not increase degree of distribution if offset and dist is over-value
		if deg_dist <= offset * dist:
			deg_dist += dist
		
		# append the negative and positive [RayCast3D]
		_offset.append(rc)
		_offset.append(rcm)

## Return the lists offset of [RayCast3D]
func get_list_ray_casts() -> Array[RayCast3D]:
	return _offset

## Construct the interaction with [RayCast3D] with distribution and radius calculation
func construct_interaction_casts() -> void:
	var median: int = 0
	
	# radius will be halved if mirror is enable
	radius = radius if mirror else radius / 2
	
	# check if number of maximum [RayCast3D] is either even or odd
	if max_raycasts % 2 != 0:
		pass
	else:
		max_raycasts = max_raycasts - 1 if mirror else max_raycasts / 2
		median = floor(max_raycasts)
	
	set_lists_offset_ray_casts(max_raycasts, radius / max_raycasts)
	
	if median > 0:
		_offset.insert(median, ray_cast(0, _actor.get_collision_mask()))
	
	for i in get_list_ray_casts():
		call_deferred('add_child', i)

func _on_enable_interaction_casts() -> void:
	for i in get_list_ray_casts():
		i.enabled = true

func _on_disable_interaction_casts() -> void:
	for i in get_list_ray_casts():
		i.enabled = false
