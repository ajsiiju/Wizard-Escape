extends CanvasLayer

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED
	$MainMenuTheme.play()

func _on_play_button_pressed() -> void:
	$UIClick.play()
	await get_tree().create_timer(0.8).timeout
	get_tree().change_scene_to_file("res://Scenes/start.tscn")
	


func _on_quit_button_pressed() -> void:
	$UIClick.play()
	await get_tree().create_timer(0.8).timeout
	get_tree().quit()
