extends Node3D
class_name Stage


## A basic signal to enable physics of the [Stage], this signal is no need to connect manually rather than the method
## [method Classes.connect_signals] or any object that inherit class [Stage.Classes]
signal enable_physics

## A basic signal to disable physics of the [Stage], this signal is no need to connect manually rather than use the method
## [method Classes.connect_signals] or any object that inherit class [Stage.Classes]
signal disable_physics

## User identifier name (uid) it's a custom variable for key in object to represet the identifier unique
## of every [Item] registered
var uid: String

## Collection of nodes to posts [Stage] where the characters are spawned or started in certain point
@export var posts: Array[NodePath]
## Collection node location [Camera]
@export var cameras: Array[NodePath]

@export_category('Development')
@export var development_mode: bool = true
## Variable uid default if level is not present or null
@export var camera_uid: String

## Variable reference for public access and assessment of the object [Stage.Classes]
var classes: Classes

## The main object of classes control of the [Stage]
class Classes extends StageClass:
	func _init(n: Stage):
		development = n.development_mode
		node    = n
		
		for i in node.posts:
			posts.append(node.get_node_or_null(i))
		
		for i in node.cameras:
			cameras.append(node.get_node_or_null(i))
		
		if node.has_signal('enable_physics') and !node.enable_physics.is_connected(enable_physics_process):
			node.enable_physics.connect(enable_physics_process)
			
		if node.has_signal('disable_physics') and !node.disable_physics.is_connected(disable_physics_process):
			node.disable_physics.connect(disable_physics_process)
	
	func set_camera() -> void:
		for i in cameras:
			i.actor_selected = []
			i.current        = false
		
		activate_camera(level.camera_uid if level != null else node.camera_uid)
		
		active_camera.current = true
	
	func set_posts() -> void:
		for x in posts:
			for i in x.get_children():
				if i is Actor:
					active_post.remove_child(i)
		
		activate_post(level.post if level != null else 0)
		
		if level != null:
			var player = level.classes.first_player()
			player.reset_state.emit()
			
			active_post.add_child(player)
			active_camera.actor_selected = level.classes.players
			active_camera.follow_actor   = true
			active_camera.focus_actor    = 0
