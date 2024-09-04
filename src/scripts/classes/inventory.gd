class_name InventoryClass

var _inventory: Node

func set_inventory(node: Node) -> void:
	_inventory = node

func get_inventory() -> Node:
	return _inventory

var _items: Array[Item]

func append_item(item: Item) -> void:
	_items.append(item)

func get_items() -> Array[Item]:
	return _items
