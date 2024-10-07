extends Control
class_name QuestLists

## Container and UI of the quests list
##
## Container and UI of the quests list

## A basic signal to enable input of the [QuestLists], this signal is no need to connect manually rather than
## use the method [method Classes.connect_signals] or any object that inherit class [QuestLists.Classes]
signal enable_input

## A basic signal to disable input of the [QuestLists], this signal is no need to connect manually rather than
## use the method [method Classes.connect_signals] or any object that inherit class [QuestLists.Classes]
signal disable_input

## Signal to sending the UI into start/showing mode
signal start
## Signal to sending the UI into end/closing mode
signal end

signal selected(v: QuestItem)

@export var use_component: bool = true
## Variable location path of container that will be used for lists quest placement
@export var lists_wrapper: NodePath

## Main classes of the [QuestItemClass]
class Classes extends QuestListsClass:
	var _result: Array[QuestItem]
	
	var _container: Container
	
	# Called when the object class is constructed for the first time
	func _init(n: QuestLists):
		node = n
		
		_container = node.get_node_or_null(node.lists_wrapper)
	
	## A primary method to filter a property with the value
	func filter(p: String, v: Variant) -> void:
		for i in quest_items:
			assert(p in i.get_property_list(), 'Error! Property %s not found: %s' % [p, i.name])
			
			if i.get(p) == v:
				_result.append(i)
	
	## Return all the filtered/unfiltered value from property or just show all
	func all() -> Array[QuestItem]:
		return _result if !_result.is_empty() else quest_items
	
	## A method to render the lists of the quest into the button rows UI
	func render_lists(v: Array[QuestItem]) -> void:
		var wrapper = node.get_node_or_null(node.lists_wrapper)
		
		# iterate and clear all the child
		for i in wrapper.get_children():
			wrapper.remove_child(i)
			i.queue_free()
		
		# re-instantiate and inheritance to the wrapper
		for i in v:
			var button: Button
			
			if node.use_component:
				button = QuestItemButtonComponent.new()
				button.quest_item = i
				button.quest_list = node.get_path()
		
			wrapper.add_child(button)

var classes: Classes

## Return the get class as custom class_name
func get_class(): return 'QuestLists'

## Set the is class if name is match with get_class or super
func is_class(v: String): return v == get_class() or super(v)

