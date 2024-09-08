extends Stage3DClass
class_name Stage3DProcessorClass

func append_area_edge(area: Area3D) -> void:
	get_area_edges().append(area)

func reset_area_edges() -> void:
	set_area_edges([])

func append_spawn_point(node: Node3D) -> void:
	get_spawn_points().append(node)

func reset_spawn_points() -> void:
	set_spawn_points([])
