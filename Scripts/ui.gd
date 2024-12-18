extends CanvasLayer

@onready var time_label: Label = $TimeLabel
@onready var win_screen: Control = $WinScreen

func _ready() -> void:
	update_time_label(LevelManager.total_time)

func _process(delta: float) -> void:
	update_time_label(LevelManager.total_time)

func update_time_label(time: int):
	time_label.text = "Time: " + str(time)

func toggle_win_screen(should_show: bool):
	win_screen.visible = should_show
	win_screen.set_time_label_text()
