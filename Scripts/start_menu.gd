extends CanvasLayer

func _on_start_button_pressed() -> void:
	LevelManager.reset_game()

func _on_quit_button_pressed() -> void:
	get_tree().quit()
