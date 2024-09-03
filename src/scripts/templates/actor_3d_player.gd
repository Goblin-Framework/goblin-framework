extends Actor3DTemplate
class_name Actor3DPlayerTemplate

# Called when the node enters the scene tree for the first time.
func _enter_tree():
	construct_actor_path_finding($'.')

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	physics_process_actor_path_finding(delta)
	move_and_slide()
