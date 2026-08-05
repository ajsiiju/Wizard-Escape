extends CanvasLayer

@onready var black_screen: ColorRect = $BlackScreen/ColorRect
var active_tween := create_tween()

func _ready() -> void:
	$MainMenuTheme.play()
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED


func _on_play_button_pressed() -> void:
	$UIClick.play()
	active_tween = create_tween()
	active_tween.tween_property(black_screen, "color", Color(0.0, 0.0, 0.0, 1.0), 0.8).set_trans(Tween.TRANS_LINEAR)
	await get_tree().create_timer(0.8).timeout
	get_tree().change_scene_to_file("res://Scenes/start.tscn")


func _on_quit_button_pressed() -> void:
	$UIClick.play()
	await get_tree().create_timer(0.8).timeout
	get_tree().quit()
