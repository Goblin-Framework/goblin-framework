extends Actor3DNavPathComponent

func _ready():
	set_actor_navpath_component($'.')

func _physics_process(delta):
	set_actor_navpath_physics_process(delta)
	move_and_slide()
