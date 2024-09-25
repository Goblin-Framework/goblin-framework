extends Control
class_name Dialogue

## Signal event to starting the [Dialogue] and start to reading line from the logs
signal start
## Signal event when dialogue is finished (Connect it from the node that trigger the start)
signal finish
## Signal event to enable the input [Dialogue]
signal enable_input
## Signal event to disable the input [Dialogue]
signal disable_input

## Variable group name for the node [Actor3D]
@export var groupname: String = 'dialogue'

@export_category('Class')
## Define the label is using parent as the visibility/trigger shown
@export var parent_label: bool

@export_subgroup('Nodes')
## Node location path of the active [Label]
@export var active: NodePath
## Node location path of the primary [Label]
@export var primary: NodePath
## Node location path of the logs [RichTextLabel]
@export var logs: NodePath


## Processor class of the [Dialogues]
class Process extends DialogueProcessorClass:
	func _init(n: Dialogue) -> void:
		set_dialogue(n)
		set_persist(get_dialogue())
	
	# Method to activate/connect basic signal
	func connect_signals() -> void:
		get_dialogue().enable_input.connect(enable_input)
		get_dialogue().disable_input.connect(disable_input)
	
	# Method to deactivate/disconnect basic signal
	func disconnect_signals() -> void:
		get_dialogue().enable_input.disconnect(enable_input)
		get_dialogue().disable_input.disconnect(disable_input)
	
	## Method to hide all the labels in the dialogues such as active and primary [Label]
	func hide_labels() -> void:
		get_active_label().visible  = false
		get_primary_label().visible = false
	
	## Method to show and set the text of the active [Label]
	func set_active(v: String) -> void:
		get_active_label().text = v
		get_active_label().visible = true
		
	## Method to show and set the text of the primary [Label]
	func set_primary(v: String) -> void:
		get_primary_label().text = v
		get_primary_label().visible = true
	
	## A method to read the next line of the logs data in set it into the textarea [RichTextLabel]
	func next() -> void:
		# check if tween exists and is running then force it to finishing the time
		if get_tween() != null and get_tween().is_running():
			get_tween().custom_step(get_time())
		
		else:
			if get_line() is Array:
				parse_callables(get_line())
			
			else:
				# this will be processing the parsing log string, hide labels, and reset visible_ratio of the textarea
				var parse = parse_log_string(get_line())
				
				hide_labels()
				
				get_log_textarea().visible_ratio = 0
				get_log_textarea().text = parse.log
				
				if 'name' in parse:
					if parse.active:
						set_active(parse.name)
					else:
						set_primary(parse.name)
				
				tween_animation()
			skip_line(1)

var processor: Process
