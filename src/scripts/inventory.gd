extends Control
class_name Inventory

## A basic signal to enable input of the [Inventory], this signal is no need to connect manually rather than
## use the method [method Classes.connect_signals] or any object that inherit class [Inventory.Classes]
signal enable_input

## A basic signal to disable input of the [Inventory], this signal is no need to connect manually rather than
## use the method [method Classes.connect_signals] or any object that inherit class [Inventory.Classes]
signal disable_input

## Signal to sending the UI into start/showing mode
signal start
## Signal to sending the UI into end/closing mode
signal end

signal deposit(uid:String, amount: float)

signal withdraw(uid: String, amount: float)

@export var wrapper: NodePath
@export var items: Array[Resource]

class Classes extends InventoryClass:
	## Variable collection of items that has been instantiated
	var items: Array[Item]
	
	## Variable wrapper of the container inventory
	var wrapper: Container
	
	# private variable to reference filter 
	var _filter: Array[Item]
	
	func _init(n: Inventory):
		node    = n
		wrapper = node.get_node_or_null(node.wrapper)
		
		for i in node.items:
			items.append(i.instantiate())
	
	## A primary method to filter a property with the value
	func filter(p: String, v: Variant) -> void:
		_filter = []
		
		for i in items:
			if i.get(p) == v:
				_filter.append(i)
	
	## Return all the filtered/unfiltered value from property or just show all
	func all() -> Array[Item]:
		return _filter if !_filter.is_empty() else items
	
	func first() -> Item:
		return _filter[0] if !_filter.is_empty() else items[0]
	
	func render_grid() -> void:
		var item = []
		
		for i in wrapper.get_children():
			wrapper.remove_child(i)
		
		for i in node.get_children():
			if i is Item:
				var sprite = TextureRect.new()
				sprite.texture = load('res://icon.svg')
				
				if i.classes.amount > 1:
					var amount  = Label.new()
					amount.text = str(i.classes.amount)
					sprite.add_child(amount)
					wrapper.call_deferred('add_child', sprite)
					item.append(sprite)
		
		for i in range(0, 30 - item.size()):
			var sprite = TextureRect.new()
			sprite.texture = load('res://src/assets/images/inventory-slot.svg')
			wrapper.call_deferred('add_child', sprite)

var classes: Classes

## Return the get class as custom class_name
func get_class(): return 'Inventory'

## Set the is class if name is match with get_class or super
func is_class(v: String): return v == get_class() or super(v)
