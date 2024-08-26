extends Actor3DNavigatedComponent

func _ready():
	setup_actor_navigated($'.')

func _physics_process(delta):
	physics_process_actor_navigated(delta)
	move_and_slide()
