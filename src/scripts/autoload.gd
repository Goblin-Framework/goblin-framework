extends Node

const SAVE_FILENAME_AUTOSAVE = 'user://autosave.save'
#TODO: tambahkan comment dokumentasi pada method disini

func save_state_autosave() -> void:
	var file  = FileAccess.open(SAVE_FILENAME_AUTOSAVE, FileAccess.WRITE)
	var nodes = get_tree().get_nodes_in_group('persist')
	
	for i in nodes:
		assert(i.has_method('get_state'), 'Node does not have method get_state')
		
		var data = i.call('get_state')
		var json = JSON.stringify(data)
		
		file.store_line(json)

func load_state_autosave():
	if not FileAccess.file_exists(SAVE_FILENAME_AUTOSAVE):
		return
	
	var nodes = get_tree().get_nodes_in_group('persist')
	for i in nodes:
		i.queue_free()
	
	var file = FileAccess.open(SAVE_FILENAME_AUTOSAVE, FileAccess.READ)
	while file.get_position() < file.get_length():
		var json  = JSON.new()
		var parse = json.parse(file.get_line())
		var data  = json.get_data()
		
		var object = load(data.filename).instantiate()
		object.load_state(data)
