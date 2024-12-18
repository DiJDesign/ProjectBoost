extends Control

@onready var your_time_label: Label = $YourTimeLabel

func set_time_label_text():
	your_time_label.text = "Your Time: " + str(LevelManager.total_time)

func _on_play_again_button_pressed() -> void:
	LevelManager.reset_game()

func _on_return_to_main_menu_button_pressed() -> void:
	pass # Replace with function body.

func _on_quit_button_pressed() -> void:
	get_tree().quit()
