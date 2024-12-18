extends CSGBox3D

@export var is_final_level: bool = false
@export var next_scene_index: int

func get_is_final_level() -> bool:
	return is_final_level
