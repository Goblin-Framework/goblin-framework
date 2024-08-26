extends Camera3DNavigatedActorComponent

# Called when the node enters the scene tree for the first time.
func _ready():
	setup_camera_navigated_actor($'.', 8.5)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if get_active_actor() != null:
		set_actor_camera(get_active_actor())
	
	physics_process_camera_navigated(delta)

func _input(event):
	input_camera_base(event)
