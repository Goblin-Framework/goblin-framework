extends Node
class_name ItemComponent

@export var item_unique_key: String
@export var item_name: String

@export_subgroup('Properties')
@export var weight: float
@export var price: float
@export var amount: float

@export_subgroup('Modifier')
@export var consumable: bool = false

var _inventory: InventoryComponent

# Called when the node enters the scene tree for the first time.
func _ready():
	_inventory = get_parent()

## A method to alter the properties of amount
func alter_amount(v: float) -> void:
	# if amount is more than equals zero then alter amount is validate
	if amount >= 0:
		amount = amount + v
	
	# if amount is less than zero (deplted) then remove from inventory
	if amount < 1 and _inventory:
		_inventory.call_deferred('remove_child', $'.')

## Return the value of total weight (weight multiply by amount)
func get_total_weight() -> float:
	return amount * weight

func get_details() -> Dictionary:
	return {
		'name'        : item_name,
		'amount'      : amount,
		'weight'      : weight,
		'price'       : price,
		'total_weight': get_total_weight(),
		'consumable'  : consumable
	}
