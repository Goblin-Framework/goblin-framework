extends Camera3DProcessorClass
class_name Camera3DPhysicsClass

## Variable reference for step value for zoom in or out
var _zoom_step: float

## Set the value of the zoom step
func set_zoom_step(value: float) -> void:
	_zoom_step = value

## Return the value of the zoom step
func get_zoom_step() -> float:
	return _zoom_step

## Method to increase zoom by size (orthogonal projection)
func zoom_in(min_zoom: float):
	if get_camera().projection == get_camera().PROJECTION_ORTHOGONAL:
		if get_camera().size >= min_zoom:
			get_camera().size -= get_zoom_step()

## Method to decrease zoom by size (orthogonal projection)
func zoom_out(max_zoom: float):
	if get_camera().projection == get_camera().PROJECTION_ORTHOGONAL:
		if get_camera().size <= max_zoom:
			get_camera().size += get_zoom_step()

## Method to moving [Camera3D] upward position
func upward():
	get_camera().transform.origin += get_cross_vector().vertical

## Method to moving [Camera3D] leftward position
func leftward():
	get_camera().transform.origin -= get_cross_vector().horizontal

## Method to moving [Camera3D] rightward position
func rightward():
	get_camera().transform.origin += get_cross_vector().horizontal

## Method to moving [Camera3D] downward position
func downward():
	get_camera().transform.origin -= get_cross_vector().vertical
