extends Camera3DClass
class_name Camera3DProcessorClass

## Variable reference for object [PhysicsRayQueryParameters3D]
var _ray_query: PhysicsRayQueryParameters3D = PhysicsRayQueryParameters3D.new()

## Variable reference for cross vector value for horizontal and vertical transform
var _cross_vector: Dictionary

## Set cross vector value for horizontal and vertical transform position on mouse sensitivity
func set_cross_vector(sensitivity: Vector2) -> void:
	_cross_vector.horizontal = _node.transform.basis.z.cross(Vector3(1, 0, 1)) / sensitivity.x
	_cross_vector.vertical   = _node.transform.basis.z.cross(Vector3(1, 0, -1)) / sensitivity.y

## Return the cross vector value for horizontal and vertical transform position
func get_cross_vector() -> Dictionary:
	return _cross_vector

## Variable reference ray [Camera3D] into world 3D
var _camera_ray: Dictionary

## A method to projecting ray [Camera3D] into world 3D
func projecting_camera_ray() -> void:
	_camera_ray.origin = _node.project_ray_origin(get_cursor())
	_camera_ray.target = _node.project_ray_normal(get_cursor()) * get_z_length() + _camera_ray.origin

## Return the value of ray [Camera3D] 
func get_camera_ray() -> Dictionary:
	return _camera_ray

## Variable bucket for projection information between intersection ray of camera and world 3D
var _projection_information: Dictionary

## Set the information of projection ray between camera and world 3D
func set_world_3D_projection_ray(world_3d: PhysicsDirectSpaceState3D, area_collision: bool):
	assert(not get_camera_ray().is_empty(), '')
	
	_ray_query.from = get_camera_ray().origin
	_ray_query.to   = get_camera_ray().target
	_ray_query.collide_with_areas = area_collision
	
	_projection_information = world_3d.intersect_ray(_ray_query)

## Return the information of projection ray between camera and world 3D
func get_world_3D_projection_ray() -> Dictionary:
	return _projection_information

func get_cursor_edges() -> Variant:
	if get_cursor().y < 1:
		return 'up'
	if get_cursor().x < 1:
		return 'left'
	if get_viewport_size().x - get_cursor().x <= 1:
		return 'right'
	if get_viewport_size().y - get_cursor().y <= 1:
		return 'down'
	
	return null
