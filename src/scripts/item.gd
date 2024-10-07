extends Node
class_name Item

## User identifier name (uid) it's a custom variable for key in object to represet the identifier unique
## of every [Item] registered
var uid: String

## The name of the [Item] it self, it will be represent on the UI as the name/title of the [Item]
@export var title: String
## Handful description of the [Item] it self, to give the detail information on player perspective what
## is the purpose of the [Item] and what is used for.
@export var description: String
@export var weight: float
@export var price: int

class Classes extends ItemClass:
	func _init(n: Item):
		node = n

var classes: Classes

## Return the get class as custom class_name
func get_class(): return 'Item'

## Set the is class if name is match with get_class or super
func is_class(v: String): return v == get_class() or super(v)
