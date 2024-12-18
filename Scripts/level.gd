extends Node3D

var timer: Timer = Timer.new() # Timer to set up for the time tracking

var levels: Array[PackedScene] = [
	preload("res://Scenes/Levels/level.tscn"),
	preload("res://Scenes/Levels/level02.tscn"),
	preload("res://Scenes/Levels/level03.tscn"),
	preload("res://Scenes/Levels/level04.tscn")
]

func _ready() -> void:
	add_child(timer)

func load_next_level():
	var landing_pad = get_tree().get_nodes_in_group("Goal")
	get_tree().change_scene_to_packed(levels[landing_pad[0].next_scene_index])

func reset_level():
	get_tree().reload_current_scene()
