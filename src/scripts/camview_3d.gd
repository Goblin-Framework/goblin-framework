extends Camera3D
class_name CamView3D

## Signal to trigger disable/deactivate physics_process
signal disable_physics
## Signal to trigger enable/activate physics_process
signal enable_physics

@export var groupname: String = 'camera'

@export_subgroup('Inputs')
## Input name when zoom in is fired
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

@export_subgroup('Actors')
## Variable [Actor3D] selected to be interact with [CamView3D]
@export var actor_selected: Array[Actor3D]
## Signal name for playable [Actor3D] when camera is pointing to object
@export var signal_navigation_interact: String = 'navigation_interact_to'


## A main physics class of the [CamView3D]
class Physics extends Camera3DPhysicsClass:
	## Constructor method class [CamView3D.Physics]
	func _init(n: CamView3D) -> void:
		set_camera(n)
	
	## Set the cross vector calculation by sensitivity value
	func set_cross_vector_calculation(sensitivity) -> void:
		set_cross_vector(Vector2(sensitivity, sensitivity * 1.5))
		
	func set_selected(d: Dictionary) -> void:
		# reset the array actor selected
		get_camera().actor_selected = []
		
		if not d.is_empty():
			var c = d.collider
			
			if c.get_class() == 'CharacterBody3D':
				get_camera().actor_selected = [c]
	
## Class utilities for angle top-down in [CamView3D]
class TopDown extends Physics:
	var _origin: Vector3
	
	## Constructor method class [CamView3D.TopDown]
	func _init(node: CamView3D) -> void:
		super(node)
		set_z_length(get_camera().z_length)
		_origin = get_camera().transform.origin
	
	## Modifier transform origin of the [CamView3D] following with player origin
	func follow_actor() -> void:
		get_camera().transform.origin = _origin + get_actor().transform.origin


## Variable physics object class [CamView3D.Physics]
var physics: Physics
## Variable reference for class [CamView3D.TopDown]
var top_down: TopDown
