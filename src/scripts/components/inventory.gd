extends Node
class_name InventoryComponent

func add_item(item: ItemComponent, amount: float) -> void:
	print("pisdfapidufa", item)
	
	for i:ItemComponent in get_children():
		if item.item_unique_key == i.item_unique_key:
			i.update_amount(amount)
			return
	
	print('pwoeriwpqoei')
	call_deferred('add_child', item)
	item.update_amount(amount)
	print(get_children())

func remove_item(item: ItemComponent, amount: float) -> void:
	item.update_amount(-amount)

func get_all_item() -> Array:
	return get_children()
