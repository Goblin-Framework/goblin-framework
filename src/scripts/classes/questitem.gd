extends PersistsClass
class_name QuestItemClass

## The class of the quest item
##
## The class of the quest item

## A enum constant value to define the statuses of the quest item it self
enum STATUSES {INACTIVE, ACTIVE, ACCEPTED, FINISHED, FAILED}

## A constant variable of the groupname of the [QuestItem]
const GROUPNAME = 'quest_item'

## A constant variable to defined the error parent of the [QuestItem]
const ERROR_PARENT = 'Fatal Error! The node must be a child of \'QuestLists\' node:'

## Variable node of parent [QuestItem], [QuestLists]
var quest_lists: QuestLists

## variable main node of the [QuestItem]
var node: QuestItem:
	## Set the variable node of the [QuestItem]
	set(n):
		assert(n.get_parent() is QuestLists, ERROR_PARENT + n.name)
		
		node        = n
		persists    = node
		groupname   = GROUPNAME
		quest_lists = node.get_parent()
	
	## Return the variable node of the [QuestItem]
	get:
		return node

