extends Camera3DBasePhysics
class_name Camera3DProcessor

var _ray_query_3d: PhysicsRayQueryParameters3D
var _world_space_3d: PhysicsDirectSpaceState3D
var _z: float

## Method constructor for [Camera3DTopDown]
func _init(node: Camera3D):
	super(node)
	_ray_query_3d = PhysicsRayQueryParameters3D.new()

## Set the value of physics space 3D
func set_world_3d_space(value: PhysicsDirectSpaceState3D):
	_world_space_3d = value

## Calculate the cursor position based on the origin and target [Vector3]
func cursor_in_world_3d(origin: Vector3, target: Vector3, collide_with_areas := false) -> Dictionary:
	_ray_query_3d.from = origin
	_ray_query_3d.to   = target
	_ray_query_3d.collide_with_areas = collide_with_areas
	
	return _world_space_3d.intersect_ray(_ray_query_3d)

## Set the Z length for top down 3D
func set_z_length(value: float):
	_z = value

## Get the result of cursor point in top-down
func get_camera_cursor_point() -> Dictionary:
	return camera_ray_pos(_z)
