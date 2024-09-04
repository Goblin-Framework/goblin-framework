extends InventoryClass
class_name InventoryProcessor

func set_an_item(item: Item, amount: float) -> void:
	if item.has_signal('increase_amount') and item.has_signal('decrease_amount'):
		for i:Item in get_inventory().get_children():
			# Check if uid is equals then item just need to set the new amount and return the method
			if item.item_uid == i.item_uid:
				if amount > 0:
					i.emit_signal('increase_amount', abs(amount), get_inventory())
				if amount < 0:
					i.emit_signal('decrease_amount', abs(amount), get_inventory())
				return
		
		get_inventory().add_child(item)
		append_item(item)
		
		if amount > 0:
			item.emit_signal('increase_amount', abs(amount), get_inventory())
		if amount < 0:
			item.emit_signal('decrease_amount', abs(amount), get_inventory())
	
