extends CanvasLayer
@onready var cauldron: Node3D = $"../Cauldron"
@onready var is_pause_menu_visible := false 


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		if is_pause_menu_visible == false:
			$MainMenuTheme.play()
			$".".visible = true
			Input.mouse_mode = Input.MOUSE_MODE_CONFINED
			get_tree().paused = true
			is_pause_menu_visible = true
		elif is_pause_menu_visible == true:
			$MainMenuTheme.stop()
			$".".visible = false
			if cauldron.is_open == false:
				Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			get_tree().paused = false
			is_pause_menu_visible = false


func _on_return_button_pressed() -> void:
	$UIClick.play()
	$MainMenuTheme.stop()
	$".".visible = false
	is_pause_menu_visible = false
	if cauldron.is_open == false:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	get_tree().paused = false


func _on_restart_button_pressed() -> void:
	$UIClick.play()
	await get_tree().create_timer(0.8).timeout
	$MainMenuTheme.stop()
	$".".visible = false
	is_pause_menu_visible = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_quit_button_pressed() -> void:
	$UIClick.play()
	await get_tree().create_timer(0.8).timeout
	get_tree().quit()
