extends Camera3DNavPathActorsComponent

func _ready():
	set_camera_navpath_component($'.')

func _physics_process(delta):
	var cursor = get_viewport().get_mouse_position()

	set_camera_navpath_interact_physics_process(cursor)
	set_camera_events_physics_process(cursor)
