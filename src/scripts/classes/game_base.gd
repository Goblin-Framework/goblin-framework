extends Node
class_name GameBase

## Return the fps value of the engine
func get_fps() -> int:
	return Engine.get_frames_per_second()
