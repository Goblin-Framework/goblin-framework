class_name RootClass

## Class object root game
##
## Class object root game

## Variable main node of the [Root]
var node: Root

## Variable collection nodes of the [Scene] in [Root]
var scenes: Array[Scene]

## Variable active node of the [Scene] in [Root]
var active_scene: Scene

## Variable main node of UI of the main menu
var main_menu: Control
 
## A metnod to set the activate scene by finding the match uid of the [Scene]
func activate_scene(v: String) -> void:
	for i in scenes:
		if i.uid == v:
			active_scene = i
			return
