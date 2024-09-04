extends ItemClass
class_name ItemProcessor

func set_item_amount(amount: float, inventory: Inventory) -> void:
	set_amount(get_amount() + amount)
	update_total_weight()
	
	if get_amount() < 1 and inventory.has_signal('remove_item'):
		inventory.remove_child(get_item())

var _total_weight: float

func update_total_weight() -> void:
	_total_weight = get_amount() * get_weight()

func get_total_weight() -> float:
	return _total_weight
