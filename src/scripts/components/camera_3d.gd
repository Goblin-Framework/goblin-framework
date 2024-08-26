extends Camera3D
class_name Camera3DComponent

## Signal to trigger disable/deactivate physics_process
signal disable_physics
## Signal to trigger enable/activate physics_process
signal enable_physics

## Variable group name for the node [Camera3DComponent]
@export var groupname: String = 'camera'
## Input name when zoom in is fired
@export var zoom_in_input: String = 'zoom_in'
## Input name when zoom out is fired
@export var zoom_out_input: String = 'zoom_out'
## Input name for reset view back to actor
@export var reset_view_input: String = 'reset_view'
## Step value when zoom events is fired
@export_range(.1, 1) var zoom_step: float = .25
## Minimum zoom value (Zoom-in)
@export_range(1, 99) var min_zoom: float = 4.0
## Maximum zoom value (Zoom-out)
@export_range(1, 99) var max_zoom: float = 12.0

@export_category('Top-down angle')
## Z length axis value between [Camera3D] to world 3D
@export var z_length: float = 100.0
## Enable/Disable camera movement based on cursor on the edges of screen
@export var screen_edges: bool = true
@export var follow_actor: bool = true

class Physics extends Camera3DPhysicsClass:
	
	func _init(camera: Camera3DComponent):
		set_camera(camera)
	
class PhysicsTopDown extends Physics:
	var _originated: Vector3
	
	func _init(camera: Camera3DComponent, sensitivity: float):
		super(camera)
		set_cross_vector(Vector2(sensitivity, sensitivity * 1.5))
		
		_originated = get_camera().transform.origin
	
	func set_events_by_cursor(cursor: Vector2, step_zoom: float) -> void:
		set_cursor(cursor)
		set_zoom_step(step_zoom)
	
	func follow_actor() -> void:
		get_camera().transform.origin = _originated + get_actor().transform.origin

var _object: Physics

## Method for setup base camera
func setup_camera_base(camera: Camera3DComponent, sensitivity: float, object: Physics) -> void:
	# Checking the groupname whether is empty or else and then adding to group if the nodes is not in group
	assert(not groupname.is_empty() or groupname != '', 'Camera3D node must be set for groupname')
	
	if not is_in_group(groupname):
		add_to_group(groupname)
	
	_object = object
	
	enable_physics.connect(object.enable_physics)
	disable_physics.connect(object.disable_physics)

func physics_process_camera_base(delta: float) -> void:
	var cursor = get_viewport().get_mouse_position()
	
	_object.set_events_by_cursor(cursor, zoom_step)
	_object.set_viewport_size(get_viewport().get_window().size)
	
	if Input.get_action_strength(zoom_in_input) > 0:
		_object.zoom_in(min_zoom)
		
	if Input.get_action_strength(zoom_out_input) > 0:
		_object.zoom_out(max_zoom)
		
	if screen_edges:
		if _object.get_cursor_edges() == 'up':
			follow_actor = false
			_object.upward()
		
		if _object.get_cursor_edges() == 'down':
			follow_actor = false
			_object.downward()
		
		if _object.get_cursor_edges() == 'left':
			follow_actor = false
			_object.leftward()
		
		if _object.get_cursor_edges() == 'right':
			follow_actor = false
			_object.rightward()
	
	if follow_actor and _object.get_actor() != null:
		_object.follow_actor()

func input_camera_base(event) -> void:
	if Input.is_action_just_pressed(reset_view_input):
		follow_actor = true
	
func set_actor_camera(actor: CharacterBody3D) -> void:
	_object.set_actor(actor)
