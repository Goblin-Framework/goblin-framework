extends Node
class_name InventoryComponent

	
func add_item(item: ItemComponent, amount: float) -> void:
	
	for i:ItemComponent in get_children():
		if item.item_unique_key == i.item_unique_key:
			i.update_amount(amount)
			return
	
	call_deferred('add_child', item)
	item.update_amount(amount)

func get_inventory_state() -> Array:
	var contents = []
	
	for i: ItemComponent in get_children():
		contents.append({
			'filename': i.scene_file_path,
			'amount'  : i.amount
		})
	
	return contents

func remove_item(item: ItemComponent, amount: float) -> void:
	item.update_amount(-amount)

func get_all_item() -> Array:
	return get_children()
