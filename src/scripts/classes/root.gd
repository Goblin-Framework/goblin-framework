class_name RootClass

## Class object root game
##
## Class object root game

## Variable main node of the [Root]
var node: Root

## Variable collection nodes of the [Level] in [Root]
var levels: Array[Level]

## Variable active node of the [Level] in [Root]
var active_level: Level

## Variable main node of UI of the main menu
var main_menu: Control
 
## A metnod to set the activate level by finding the match uid of the [level]
func activate_level(v: String) -> void:
	for i in levels:
		if i.uid == v:
			active_level = i
			return
