extends NavigationAgent3D
class_name PathFindingAgentComponent

var _actor: Actor3D
var _timer: Timer

## Enable/Disable the delay [PathFindingAgentComponent] when constantly update navigattion
@export var enable_delay_interval: bool
## This will delay the [PathFindingAgentComponent] to re-navigate the actor if navigation is constantly update
@export var delay_interval_seconds: float = 2.0

var active: bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	if enable_delay_interval:
		_timer = Timer.new()
		_timer.autostart = false
		_timer.timeout.connect(_on_timer_delay_timeout)
		add_child(_timer)
	
	_actor = get_parent()
	_actor.navigation.set_navigation_agent($'.')
	
	velocity_computed.connect(_on_velocity_computed)

# Called when the timer delay is timeout
func _on_timer_delay_timeout() -> void:
	active = true

# Called when the timer delay is active/start
func _on_timer_delay_start() -> void:
	active = false
	_timer.start(delay_interval_seconds)

# Set the velocity computed to the parent node (actor)
func _on_velocity_computed(v: Vector3) -> void:
	# If physics from actor navigation is true and path finding is active
	if _actor.navigation.get_physics() and active:
		_actor.navigation.set_velocity_process(v)
		
		if enable_delay_interval:
			_on_timer_delay_start()
