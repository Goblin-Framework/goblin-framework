class_name ItemClass

var _item: Node

func set_item(node: Node) -> void:
	_item = node

func get_item() -> Node:
	return _item

var _item_uid: String

func set_item_uid(value: String) -> void:
	_item_uid = value

func get_item_uid() -> String:
	return _item_uid

var _item_name: String

func set_item_name(value: String) -> void:
	_item_name = value

func get_item_name() -> String:
	return _item_name

var _amount: float

func set_amount(value: float) -> void:
	_amount = value

func get_amount() -> float:
	return _amount

var _price: float

func set_price(value: float) -> void:
	_price = value

func get_price() -> float:
	return _price

var _weight: float

func set_weight(value: float) -> void:
	_weight = value

func get_weight() -> float:
	return _weight
