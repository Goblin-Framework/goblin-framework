extends Stage3DClass
class_name Stage3DProcessorClass

#TODO: tambahkan comment dokumentasi pada method disini

func reset_camviews() -> void:
	for i: CamView3D in get_camviews():
		assert(i.has_signal('disable_physics'), Common.Exception.signal_not_found('disable_physics', i))
		
		i.emit_signal('disable_physics')
		i.current = false

func set_camview_by_unique_name(k: String) -> void:
	for i: CamView3D in get_camviews():
		assert(i.has_method('get_unique_name'), Common.Exception.method_not_found(i))
		assert(i.has_signal('enable_physics') , Common.Exception.signal_not_found('enable_physics', i))
		
		if k == i.get_unique_name():
			i.emit_signal('enable_physics')
			i.current = true
			
			return

func reset_actor_posts() -> void:
	for i in get_actor_posts():
		for x in i.get_children():
			if x.get_class() == 'CharacterBody3D':
				i.call_deferred('remove_child', x)
