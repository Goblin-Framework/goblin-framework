extends Node
class_name Item

## Class utilities base for [Item] for the basic process of the node
class Base extends ItemProcessor:
	func _init(node: Item) -> void:
		set_item(node)

## Signal for adding amount of the [Item]
signal increase_amount
## Signal for reducing amount of the [Item]
signal decrease_amount

## Variable group name for the node [Inventory]
@export var groupname: String = 'item'
## Unique id of the [Item]
@export var item_uid: String
## Name of the [Item]
@export var item_name: String
## Weight of the [Item]
@export var weight: float
## Currency price of the [Item]
@export var price: float

## Variable reference [Item.Base]
var base: Base
