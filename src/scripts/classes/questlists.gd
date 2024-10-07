extends PersistsClass
class_name QuestListsClass

## The class of the quest lists
##
## The class of the quest lists

## A constant variable of the groupname of the [QuestLists]
const GROUPNAME = 'quest_lists'

## A constant variable to defined the error childs of the [QuestLists]
const ERROR_CHILD = 'Fatal Error! The node must have at least a \'QuestItem\' as child:'

## Variable collections of [QuestItem] in [QuestLists]
var quest_items: Array[QuestItem]

## variable main node of the [QuestLists]
var node: QuestLists:
	## Return the variable node of the [QuestLists]
	set(n):
		# first condition of the assertion is children is empty
		assert(!n.get_children().is_empty(), ERROR_CHILD + n.name)
		
		node        = n
		persists    = node
		groupname   = GROUPNAME
		
		for i in node.get_children():
			if i is QuestItem:
				quest_items.append(i)
		
		# last condition is the quest item it self is less than 0
		assert(quest_items.size() > 0, ERROR_CHILD + n.name)
	
	## Return the variable node of the [QuestLists]
	get:
		return node
