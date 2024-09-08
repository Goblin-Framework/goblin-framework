extends Camera3D
class_name CamView3D

## Class utilities base for [CamView3D] for the basic physics and process
class Base extends Camera3DPhysicsClass:
	func _init(node: CamView3D) -> void:
		set_camera(node)
	
	## Set the events that using cursor or mouse
	func set_events_by_cursor(cursor: Vector2, step_zoom: float) -> void:
		set_cursor(cursor)
		set_zoom_step(step_zoom)

## Class utilities for angle top-down in [CamView3D]
class TopDown extends Base:
	var _origin: Vector3
	
	func _init(node: CamView3D, sensitivity: float) -> void:
		super(node)
		set_cross_vector(Vector2(sensitivity, sensitivity * 1.5))
		
		_origin = get_camera().transform.origin
	
	## Modifier transform origin of the [CamView3D] following with player origin
	func follow_actor() -> void:
		get_camera().transform.origin = _origin + get_actor().transform.origin

## Signal to trigger disable/deactivate physics_process
signal disable_physics
## Signal to trigger enable/activate physics_process
signal enable_physics

@export var groupname: String = 'camera'
## Input name when zoom in is fired
@export_subgroup('Inputs')
@export var zoom_in_input: String = 'zoom_in'
## Input name when zoom out is fired
@export var zoom_out_input: String = 'zoom_out'
@export_subgroup('Zoom')
## Step value when zoom events is fired
@export_range(.1, 1) var zoom_step: float = .25
## Minimum zoom value (Zoom-in)
@export_range(1, 99) var min_zoom: float = 4.0
## Maximum zoom value (Zoom-out)
@export_range(1, 99) var max_zoom: float = 12.0

@export_category('Top-down')
## Z length axis value between [Camera3D] to world 3D
@export var z_length: float = 100.0
## Enable/Disable camera movement based on cursor on the edges of screen
@export var screen_edges: bool = true
## Enable/Disable camera movement following [Actor3D]
@export var follow_actor: bool = true

@export_category('Point-Click')
## Enable/Disable the projection interaction or select with area collision coverage
@export var area_collision: bool = false
@export_subgroup('Inputs')
## Input name for reset view back to actor
@export var reset_view_input: String = 'reset_view'
## Input name when cursor is interacting to object/colliision
@export var cursor_interact_input: String = 'cursor_interact'
## Input name when cursor is selecting to object/colliision
@export var cursor_select_input: String = 'cursor_select'
## Number of interval delay when interact is inactive and active
@export_range(.1, 3) var delay_interact_interval: float = .5
@export_subgroup('Actors')
## Node path for playable [Actor3D]
@export var playable_actors: Array[NodePath]
@export var actor: Array[Actor3D]
## Signal name for playable [Actor3D] when camera is pointing to object
@export var signal_name_interact: String = 'receive_pointing_camera_information'
## Key index for focusing which actor to be selected
@export var key_actor_focus: int = 0

## Variable reference for timer if used in [CamView3D] for interaction delay or timeout
var timer: Timer
## Variable reference for class [CamView3D.TopDown]
var top_down: TopDown
