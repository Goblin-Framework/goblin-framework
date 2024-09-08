extends Node
class_name ItemComponent

@export var item_unique_key: String
@export var item_name: String
@export_subgroup('Properties')
@export var weight: float
@export var price: float
@export var amount: float
@export_subgroup('Effects')
@export var consumable: bool = false

var _total_weight: float
var _inventory: InventoryComponent

func _ready():
	_inventory = get_parent()

func total_weight() -> void:
	_total_weight = amount * weight

func get_total_weight() -> float:
	return _total_weight

func update_amount(value: float) -> void:
	amount += value
	total_weight()
	
	if amount < 1:
		_inventory.remove_child($'.')
