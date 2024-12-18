extends Node3D

var timer: Timer = Timer.new() # Timer to set up for the time tracking
var total_time: int = 0

var levels: Array[PackedScene] = [
	preload("res://Scenes/Levels/level.tscn"),
	preload("res://Scenes/Levels/level02.tscn"),
	preload("res://Scenes/Levels/level03.tscn"),
	preload("res://Scenes/Levels/level04.tscn"),
	preload("res://Scenes/start_menu.tscn")
]

func _ready() -> void:
	add_child(timer)
	timer.timeout.connect(self.increment_time)
	timer.start(1)

func load_next_level():
	var landing_pad = get_tree().get_first_node_in_group("Goal")
	if !landing_pad.get_is_final_level():
		get_tree().change_scene_to_packed(levels[landing_pad.next_scene_index])
	else:
		var UI = get_tree().get_first_node_in_group("UI")
		UI.toggle_win_screen(true)

func reset_level():
	get_tree().reload_current_scene()

func reset_game():
	get_tree().change_scene_to_packed(levels[0])
	total_time = 0

func increment_time():
	total_time += 1
	print(total_time)

func return_to_start_menu():
	get_tree().change_scene_to_packed(levels[4])
