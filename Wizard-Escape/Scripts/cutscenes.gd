extends Node3D

var player_position := Vector3()
@onready var player: CharacterBody3D = $"../player"
@onready var player_camera: Camera3D = $"../player/CameraRig/Camera3D"
@onready var cs_character: Node3D = $CSCharacter


@onready var cauldron: Node3D = $"../Cauldron"
@onready var ui: CanvasLayer = $"../inventoryTimer"


@onready var cs_player: AnimationPlayer = $CSPLayer
@onready var cs_camera: Camera3D = $CSCamera
@onready var fade_out: CanvasLayer = $FadeOut

@onready var timer: Panel = $"../inventoryTimer/Timer"


func _ready() -> void:
	cauldron.potion_drunk.connect(_on_potion_drunk)
	timer.end_cutscene.connect(_on_end_cutscene)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("skip"):
		var time_left := cs_player.current_animation_length - cs_player.current_animation_position
		cs_player.advance(time_left)



# START DRINKING CUTSCENE
func _on_potion_drunk() -> void:
	player_position = player.position
	player.position = Vector3(-3.163, 0.294, -7.252)
	cauldron.remove_highlight()
	get_tree().paused = true
	ui.visible = false
	cs_camera.make_current()
	cs_player.play("CS_drinking_potion_blue")



	# START ENDING CUTSCENE
func _on_end_cutscene(which_potion: String) -> void:
	if which_potion == "yellow_potion":
		player.position = Vector3(-3.163, 0.294, -7.252)
		ui.visible = false
		cs_camera.make_current()
		cs_player.play("CS_right_potion")
	
	if which_potion == "pink_potion":
		player.position = Vector3(-3.163, 0.294, -7.252)
		ui.visible = false
		cs_camera.make_current()
		cs_player.play("CS_fast_potion")
	
	if which_potion == "blue_potion":
		player.position = Vector3(-3.163, 0.294, -7.252)
		ui.visible = false
		cs_camera.make_current()
		cs_player.play("CS_slow_potion")
	
	if which_potion == "no_potion":
		player.position = Vector3(-3.163, 0.294, -7.252)
		ui.visible = false
		cs_camera.make_current()
		cs_player.play("CS_no_potion")


# WHEN CUTSCENE IS FINISHED
func _on_cs_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "CS_drinking_potion_blue":
		player.position = player_position
		cs_character.position = Vector3(-3.163, 0.294, -6.411)
		get_tree().paused = false
		ui.visible = true
		fade_out.visible = false
		player_camera.make_current()
	
	if anim_name == "CS_right_potion":
		get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	if anim_name == "CS_fast_potion":
		get_tree().change_scene_to_file("res://Scenes/game_over_menu.tscn")
	if anim_name == "CS_slow_potion":
		get_tree().change_scene_to_file("res://Scenes/game_over_menu.tscn")
	if anim_name == "CS_no_potion":
		get_tree().change_scene_to_file("res://Scenes/game_over_menu.tscn")
