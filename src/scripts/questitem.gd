extends Node
class_name QuestItem

@export var title: String
@export var description: String
@export var status: QuestItemClass.STATUSES

## Main classes of the [QuestItemClass]
class Classes extends QuestItemClass:
	func _init(n: QuestItem):
		node = n

var classes: Classes

## Return the get class as custom class_name
func get_class(): return 'QuestItem'

## Set the is class if name is match with get_class or super
func is_class(v: String): return v == get_class() or super(v)
