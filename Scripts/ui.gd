extends CanvasLayer

@onready var time_label: Label = $TimeLabel

func update_time_label(time: int):
	time_label.text = "Time: " + str(time)
	
func _ready() -> void:
	update_time_label(LevelManager.total_time)

func _process(delta: float) -> void:
	update_time_label(LevelManager.total_time)
