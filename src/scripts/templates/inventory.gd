extends Inventory
class_name InventoryTemplate

func construct_inventory_object(object: Base) -> void:
	# Checking the groupname whether is empty or else and then adding to group if the nodes is not in group
	assert(not groupname.is_empty() or groupname != '', Commons.inventory_groupname_required)
	
	if not is_in_group(groupname):
		add_to_group(groupname)
	
	if not items.is_empty():
		object.initiate_items(items)
	
	add_item.connect(_on_add_item)
	remove_item.connect(_on_remove_item)

func construct_inventory_trade(node: Inventory) -> void:
	trade = Trade.new(node)
	
	construct_inventory_object(trade)

func _on_add_item(item: Item, amount: float) -> void:
	trade.set_an_item(item, amount)

func _on_remove_item(item: Item, amount: float) -> void:
	trade.set_an_item(item, -amount)

func _ready():
	construct_inventory_trade($'.')
