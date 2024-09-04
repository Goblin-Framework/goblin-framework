extends Item
class_name ItemTemplate

func construct_item_object(object: Base) -> void:
	# Checking the groupname whether is empty or else and then adding to group if the nodes is not in group
	assert(not groupname.is_empty() or groupname != '', Commons.item_groupname_required)
	
	if not is_in_group(groupname):
		add_to_group(groupname)
	
	object.set_item_name(item_name)
	object.set_item_uid(item_uid)
	object.set_weight(weight)
	object.set_price(price)
	object.set_amount(0)
	
	increase_amount.connect(_on_increase_amount)
	decrease_amount.connect(_on_decrease_amount)

func construct_item(node: Item) -> void:
	base = Base.new(node)
	construct_item_object(base)

func _on_increase_amount(amount: float, inventory: Inventory) -> void:
	base.set_item_amount(amount, inventory)
	print(base.get_amount())
	print(base.get_total_weight())

func _on_decrease_amount(amount: float, inventory: Inventory) -> void:
	base.set_item_amount(-amount, inventory)
	print('asdfadsf--')
	print(base.get_amount())
	print(base.get_total_weight())

func _ready():
	construct_item($'.')
