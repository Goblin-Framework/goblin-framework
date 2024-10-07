extends PersistsClass
class_name InventoryClass

## The inventory class
##
## THe inventory class 

## A constant variable of the groupname of the [Inventory]
const GROUPNAME = 'inventory'

## variable main node of the [Inventory]
var node: Inventory:
	## Set the variable node of the [Inventory]
	set(n):
		node      = n
		persists  = node
		groupname = GROUPNAME
	
	## Return the variable node of the [Inventory]
	get:
		return node

## A method for the inventory to deposit an [Item] with certain amount to the [Inventory]
func deposit(n: Item, v: int) -> void:
	for i in node.get_children():
		if i is Item and i.uid == n.uid:
			print(i.uid, i.name, n.uid, n.name)
			i.classes.amount = v
			return
	
	# if there's no matched the children in inventory then add the item as child
	node.call_deferred('add_child', n)
	n.classes.amount = v

## A method for the inventory to withdraw an [Item] with certain amount to the [Inventory]
func withdraw(n: Item, v: int) -> void:
	for i in node.get_children():
		if i is Item and i.uid == n.uid:
			i.classes.amount = -v
			return
