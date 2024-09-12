extends Node
class_name InventoryComponent

## Method to deposit [ItemComponent] into [InventoryComponent]
func deposit(i: ItemComponent, v: float) -> void:
	# Iterate the child content of the inventory
	for x: ItemComponent in get_children():
		
		# if uid is match the just update the amount and return the method
		if i.item_unique_key == x.item_unique_key:
			x.alter_amount(v)
			return
		
	call_deferred('add_child', i)
	i.alter_amount(v)

## Method to withdraw [ItemComponent] from [InventoryComponent]
func withdraw(i: ItemComponent, v: float) -> void:
	# Iterate the child content of the inventory
	for x: ItemComponent in get_children():
		# if uid is match the just update the amount and return the method
		if i.item_unique_key == x.item_unique_key:
			x.alter_amount(-v)
			return
