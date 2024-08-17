class_name Camera3DBasePhysics

var _camera: Camera3D
var _cursor: Vector2
var _physics_run := true

## Method constructor for [Camera3DBasePhysics]
func _init(node: Camera3D):
	_camera = node

## Method to set the cursor position on screen
func set_cursor_pos(value: Vector2) -> void:
	_cursor = value

## Return the cursor position on screen
func get_cursor_pos() -> Vector2:
	return _cursor

## Method to translate between origin and target of projecting point of the camera
func camera_ray_pos(z: float) -> Dictionary:
	var o = _camera.project_ray_origin(_cursor)
	var t = _camera.project_ray_normal(_cursor) * z + o
	
	return {'origin': o, 'target': t}

## Method to resulting the cross vector value for top-down camera position
func top_down_cross_vector() -> Dictionary:
	var f = _camera.transform.basis.z
	return {
		'x': f.cross(Vector3(1, 0, 1)) / _camera.get_mouse_sensitivity_gap().x,
		'y': f.cross(Vector3(1, 0, -1)) / _camera.get_mouse_sensitivity_gap().y
	}

## Return the [Camera3D] node
func get_camera():
	return _camera

## Method to set the physics process of the actor as inactive
func disable_physics() -> void:
	_physics_run = false
	_camera.set_physics_process(_physics_run)

## Method to set the physics process of the actor as active
func enable_physics() -> void:
	_physics_run = true
	_camera.set_physics_process(_physics_run)

## Return the physics status active or deactive
func get_physics_status() -> bool:
	return _physics_run
