extends Camera3D
class_name Camera3DComponent

## Signal to trigger disable/deactivate physics_process
signal disable_physics
## Signal to trigger enable/activate physics_process
signal enable_physics

## Variable group name for the node [Camera3DComponent]
@export var groupname: String = 'actor'

@export_category('Top-down projection')
@export var screen_edges_movement: bool = true
## Z length axis value between [Camera3D] to world 3D
@export var z_length: float = 100.0
## Input name when zoom in is fired
@export var zoom_in_input: String = 'zoom_in'
## Input name when zoom out is fired
@export var zoom_out_input: String = 'zoom_out'
## Step value when zoom events is fired
@export_range(.1, 1) var zoom_step_ort: float = .25
## Minimum zoom value (Zoom-in)
@export_range(1, 12) var min_zoom_ort: float = 4.0
## Maximum zoom value (Zoom-out)
@export_range(8, 20) var max_zoom_ort: float = 12.0
## Mouse sensitivity if projection using movement screen edges
@export_range(1, 100) var mouse_sensitivity: float = 5.0

var _top_down: TopDown
var _mouse_sensitivity = ProjectSettings.get_setting('framework/components/camera/mouse_sensitivity')

## Event for top-down projection angle [Camera3D]
class TopDown extends Camera3DProcessor:
	func _init(node: Camera3DComponent, z_length: float):
		super(node)
		set_z_length(z_length)
	
	## Action zoom in [Camera3D]
	func zoom_in(step: float, orthogonal: bool) -> void:
		if orthogonal:
			get_camera().size -= step

	## Action zoom out [Camera3D]
	func zoom_out(step: float, orthogonal: bool) -> void:
		if orthogonal:
			get_camera().size += step
	
	## Movement [Camera3D] to the left of the screen
	func left() -> void:
		get_camera().transform.origin -= top_down_cross_vector().x
	
	## Movement [Camera3D] to the right of the screen
	func right() -> void:
		get_camera().transform.origin += top_down_cross_vector().x
	
	## Movement [Camera3D] to the top of the screen
	func up() -> void:
		get_camera().transform.origin += top_down_cross_vector().y
	
	## Movement [Camera3D] to the bottom of the screen
	func down() -> void:
		get_camera().transform.origin -= top_down_cross_vector().y

## Action zoom in for [Camera3D] based on the projection and minimal_zoom
func zoom_in() -> void:
	if projection == PROJECTION_ORTHOGONAL and size >= min_zoom_ort:
		_top_down.zoom_in(zoom_step_ort, projection == PROJECTION_ORTHOGONAL)

## Action zoom in for [Camera3D] based on the projection and maximal_zoom
func zoom_out() -> void:
	if projection == PROJECTION_ORTHOGONAL and size <= max_zoom_ort:
		_top_down.zoom_out(zoom_step_ort, projection == PROJECTION_ORTHOGONAL)

## Method to get calculated mouse sensitivity
func get_mouse_sensitivity_gap() -> Vector2:
	var ms = ProjectSettings.get_setting('framework/components/camera/mouse_sensitivity')
	ms = 4.5 if ms == null else ms
		
	return Vector2(ms, ms + mouse_sensitivity)

## Set the basic construct of the [Camera3DComponent]
func set_camera_component(node: Camera3DComponent) -> void:
	# Checking the groupname whether is empty or else and then adding to group if the nodes is not in group
	assert(not groupname.is_empty() or groupname != '', 'Camera3D node must be set for groupname')
	
	if not is_in_group(groupname):
		add_to_group(groupname)
	
	enable_physics.connect(_top_down.enable_physics)
	disable_physics.connect(_top_down.disable_physics)

## Set the construct of the [Camera3DComponent] in top-down projection angle
func set_camera_top_down_component(node: Camera3DComponent) -> void:
	set_camera_component(node)
	
	_top_down = TopDown.new($'.', z_length)

## Physics process for the [Camera3DComponent] in top-down projection angle
func set_camera_events_physics_process(cursor: Vector2) -> void:
	if Input.get_action_strength(zoom_in_input) > 0:
		zoom_in()
		
	if Input.get_action_strength(zoom_out_input) > 0:
		zoom_out()
	
	if screen_edges_movement:
		if cursor.x < 1:
			_top_down.left()
		
		if cursor.y < 1:
			_top_down.up()
		
		if get_viewport().get_window().size.x - cursor.x <= 1:
			_top_down.right()
		
		if get_viewport().get_window().size.y - cursor.y <= 1:
			_top_down.down()
