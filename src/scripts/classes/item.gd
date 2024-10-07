extends PersistsClass
class_name ItemClass

## The item class
##
## THe item class 

## A constant variable of the groupname of the [Item]
const GROUPNAME = 'item'

## variable main node of the [Item]
var node: Item:
	## Set the variable node of the [Item]
	set(n):
		node      = n
		persists  = node
		groupname = GROUPNAME
	
	## Return the variable node of the [Item]
	get:
		return node

## Variable reference of the total weight of the [Item] in [Inventory]
var total_weight: float = 0

## Variable reference of the total amount/quantity of the [Item] in [Inventory]
var amount: int:
	set(v):
		var qty = amount + v
		
		if qty < 0:
			node.get_parent().remove_child(node)
			node.queue_free()
			
		else:
			amount       = qty
			total_weight = node.weight * amount
	
	get:
		return amount
