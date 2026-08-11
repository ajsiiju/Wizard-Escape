extends Panel

@onready var player: CharacterBody3D = $"../../player"
@onready var timer: Timer = $"../Timer/MarginContainer/TextureRect/Timer"
@onready var timer_UI: Panel = $"../Timer"
@onready var inventory_UI: Panel = $"../Inventory"
@onready var player_camera: Camera3D = $"../../player/CameraRig/Camera3D"
@onready var key_UI: Panel = $"../Key"



@onready var button_mashing_UI: Panel = $"."
@onready var timer_button_mashing: Timer = $MarginContainer/TextureRect/Timer
@onready var progress_bar_button_mashing: ProgressBar = $MarginContainer/TextureRect/ProgressBar

@onready var camera_3d: Camera3D = $"../../WriglingChair/Camera3D"
@onready var wrigling_chair: Node3D = $"../../WriglingChair"




@onready var chair_anim: AnimationTree = $"../../WriglingChair/ChairAnimTree"

@onready var anim_timer: Timer = $"../../WriglingChair/AnimTimer"
@onready var anim_key: AnimationPlayer = $"../Key/AnimKey"




var button_mashing_active := true
var last_button_pressed := "A"
var chair_anim_is_playing := false


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN
	player.visible = false
	camera_3d.make_current()
	anim_key.play("key_switching")


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("move_left") and last_button_pressed == "D" and button_mashing_active == true:
		last_button_pressed = "A"
		progress_bar_button_mashing.value += 1
		check_win()
		anim_timer.start()
		if chair_anim_is_playing == false:
			chair_anim_is_playing = true
	
	if event.is_action_pressed("move_right") and last_button_pressed == "A" and button_mashing_active == true:
		last_button_pressed = "D"
		progress_bar_button_mashing.value += 1
		check_win()
		anim_timer.start()
		if chair_anim_is_playing == false:
			chair_anim_is_playing = true


func _on_timer_timeout() -> void:
	progress_bar_button_mashing.value -= 0.5

func check_win() -> void:
	if progress_bar_button_mashing.value == progress_bar_button_mashing.max_value:
		timer_button_mashing.stop()
		button_mashing_UI.visible = false
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		timer_UI.visible = true
		timer.start()
		inventory_UI.visible = true
		player.visible = true
		player_camera.make_current()
		wrigling_chair.visible = false
		button_mashing_active = false
		anim_key.stop()
		key_UI.visible = false


func _on_anim_timer_timeout() -> void:
	chair_anim_is_playing = false
