extends Node3D
class_name Face3DComponent

var _intearction_instance_id: int
var _interaction_casts: Vector3 = Vector3.ZERO
var _offset: Array[RayCast3D]
var _player: Actor3D

signal enable_interaction(instance_id: int)
signal disable_interaction

@export_subgroup('Interaction')
## Radius range for interaction coverage cast
@export_range(.1, 360) var radius_degree_interaction: float = 45
## Maximum number of [RayCast3D] will be spawned
@export var raycast_number_interaction: int = 5
## Maximum cast range for interaction to be reached
@export var cast_range_interaction: float = 1
## Number of spawned [RayCast3D] will be mirrored casts interaction based on radius
@export var mirror_casts_interaction: bool = true
## Enable/Disable interaction interaction with area
@export var area_collision_interaction: bool = false
## Enable/Disable the [RayCast3D] to be always on
@export var always_enable_interaction: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	_player = get_parent()
	_interaction_casts.z = cast_range_interaction
	
	construct_interaction_casts()
	
	# if interaction is not always enable then the signal will be attach
	if not always_enable_interaction:
		enable_interaction.connect(_on_enable_interaction_casts)
		disable_interaction.connect(_on_disable_interaction_casts)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	for i in get_list_ray_casts():
		# Check if ray cast is collide with the target
		if i.is_colliding():
			var collider = i.get_collider()
			
			# check if collider instance id is same with the target instance id for interaction
			if _intearction_instance_id == collider.get_instance_id():
				# check if player using navigation object then the navigation will be stopped
				if _player.navigation != null:
					_player.navigation.get_navigation_agent().target_position = _player.global_position
				
				if collider.has_signal('interaction_casts_hit'):
					collider.emit_signal('interaction_casts_hit', _player)
				
				emit_signal('disable_interaction_casts')

## Instantiate a new [RayCast3D] with it's requirements
func ray_cast(rotate: float, mask: int) -> RayCast3D:
	var rc = RayCast3D.new()
	
	rc.rotation.y = rotate
	rc.collide_with_areas = area_collision_interaction
	rc.enabled = always_enable_interaction
	rc.target_position = _interaction_casts
	rc.set_collision_mask(mask)
	
	return rc

## Set lists offset [RayCast3D] based on distribution radius_degree_interaction
func set_lists_offset_ray_casts(offset: int, dist: float) -> void:
	var deg_dist = dist
	
	for i in range(offset):
		# positive ray cast offset
		var rc = ray_cast(deg_to_rad(deg_dist), _player.get_collision_layer())
		# negative ray cast offset (mirror_casts_interaction)
		var rcm = ray_cast(-deg_to_rad(deg_dist), _player.get_collision_layer())
		
		# will not increase degree of distribution if offset and dist is over-value
		if deg_dist <= offset * dist:
			deg_dist += dist
		
		# append the negative and positive [RayCast3D]
		_offset.append(rc)
		_offset.append(rcm)

## Return the lists offset of [RayCast3D]
func get_list_ray_casts() -> Array[RayCast3D]:
	return _offset

## Construct the interaction with [RayCast3D] with distribution and radius_degree_interaction calculation
func construct_interaction_casts() -> void:
	var median: int = 0
	
	# radius_degree_interaction will be halved if mirror_casts_interaction is enable
	radius_degree_interaction = radius_degree_interaction if mirror_casts_interaction else radius_degree_interaction / 2
	
	# check if number of maximum [RayCast3D] is either even or odd
	if raycast_number_interaction % 2 == 0:
		pass
	else:
		raycast_number_interaction = raycast_number_interaction - 1 if mirror_casts_interaction else raycast_number_interaction / 2
		median = floor(raycast_number_interaction)
	
	# Set the lists offset of the ray casts
	set_lists_offset_ray_casts(raycast_number_interaction, radius_degree_interaction / raycast_number_interaction)
	
	if median > 0:
		_offset.insert(median, ray_cast(0, _player.get_collision_layer()))
	
	for i in get_list_ray_casts():
		call_deferred('add_child', i)

#TODO: tambahkan comment dokumentasi pada method disini

func _on_enable_interaction_casts(instance_id: int) -> void:
	for i in get_list_ray_casts():
		i.enabled = true
	
	_intearction_instance_id = instance_id

func _on_disable_interaction_casts() -> void:
	for i in get_list_ray_casts():
		i.enabled = false
