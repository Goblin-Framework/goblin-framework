extends NavigationAgent3D
class_name PathFindingAgentComponent

var _actor: Actor3D

func _ready():
	_actor = get_parent()
	_actor.component_set_navigation_agent($'.')
	
	velocity_computed.connect(_on_velocity_set)

## Event/Signal method to set the velocity actor
func _on_velocity_set(value: Vector3) -> void:
	if _actor.navigation.get_physics():
		_actor.navigation.set_velocity(value)
		_actor.velocity = value
