extends Node
class_name Inventory

## Class utilities base for [Inventory] for the basic process of the node
class Base extends InventoryProcessor:
	func _init(node: Inventory) -> void:
		set_inventory(node)
	
	func initiate_items(items: Dictionary) -> void:
		var tmp: Array[Item]
		
		for i in items:
			set_an_item(i.instantiate(), items[i])

class Trade extends Base:
	func _init(node: Inventory) -> void:
		super(node)

## Signal [Inventory] for adding an new item as a child
signal add_item(item: Item, amount: float)
## Signal [Inventory] for removing an item from it's children
signal remove_item(item: Item, amount: float)

## Variable group name for the node [Inventory]
@export var groupname: String = 'inventory'
## Starter items for the [Inventory] node
@export var items: Dictionary

var trade: Trade
