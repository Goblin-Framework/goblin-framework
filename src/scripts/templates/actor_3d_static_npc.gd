extends Actor3DTemplate
class_name Actor3DStaticNpcTemplate

# Called when the node enters the scene tree for the first time.
func _enter_tree():
	base = Base.new($'.')
	construct_actor_object(base)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	physics_proces_actor_object(delta, base)
	move_and_slide()
