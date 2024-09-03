extends CamView3DTemplate
class_name CamView3DTopDownNavigated

func _enter_tree():
	construct_camview_top_down($'.', 8.75)

func _physics_process(delta):
	camview_top_down_active_actor()
	physics_process_camview_top_down(delta)

func _input(event):
	input_camview_zoom(event, top_down)
	input_camview_follow_actor_top_down()
