extends Node3D

var player_position := Vector3()
@onready var player: CharacterBody3D = $"../player"
@onready var player_camera: Camera3D = $"../player/CameraRig/Camera3D"
@onready var cs_character: Node3D = $CSCharacter


@onready var cauldron: Node3D = $"../Cauldron"
@onready var ui: CanvasLayer = $"../inventoryTimer"
@onready var cutscenes_UI: CanvasLayer = $Cutscenes_UI



@onready var cs_player: AnimationPlayer = $CSPLayer
@onready var cs_camera: Camera3D = $CSCamera
@onready var fade_out: CanvasLayer = $FadeOut

@onready var timer: Panel = $"../inventoryTimer/Timer"

@onready var pink_potion: Node3D = $CSCharacter/root/Skeleton3D/BoneAttachment3D/pink_potion
@onready var blue_potion: Node3D = $CSCharacter/root/Skeleton3D/BoneAttachment3D/blue_potion
@onready var yellow_potion: Node3D = $CSCharacter/root/Skeleton3D/BoneAttachment3D/yellow_potion
@onready var yellow_light: OmniLight3D = $CSCharacter/root/Skeleton3D/BoneAttachment3D/YellowLight
@onready var yellow_light_2: OmniLight3D = $"../player/Mesh/root/Skeleton3D/BoneAttachment3D/YellowLight2"




func _ready() -> void:
	cauldron.potion_drunk.connect(_on_potion_drunk)
	timer.end_cutscene.connect(_on_end_cutscene)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("skip"):
		var time_left := cs_player.current_animation_length - cs_player.current_animation_position
		cs_player.advance(time_left)

func cutscene_settings() -> void:
	player.position = Vector3(-3.163, 0.294, -7.252)
	ui.visible = false
	cs_camera.make_current()


# START DRINKING CUTSCENE
func _on_potion_drunk() -> void:
	player_position = player.position
	cutscene_settings()
	cauldron.remove_highlight()
	get_tree().paused = true
	cs_player.play("CS_drinking_potion")
	
	if cauldron.which_potion == "blue_potion":
		blue_potion.visible = true
	
	if cauldron.which_potion == "yellow_potion":
		yellow_potion.visible = true
	
	if cauldron.which_potion == "pink_potion":
		pink_potion.visible = true



	# START ENDING CUTSCENE
func _on_end_cutscene(which_potion: String) -> void:
	if which_potion == "yellow_potion":
		cutscene_settings()
		yellow_light.visible = true
		cs_player.play("CS_right_potion")
	
	if which_potion == "pink_potion":
		cutscene_settings()
		cs_player.play("CS_fast_potion")
	
	if which_potion == "blue_potion":
		cutscene_settings()
		cs_player.play("CS_slow_potion")
		
	
	if which_potion == "no_potion":
		cutscene_settings()
		cs_player.play("CS_no_potion")



# WHEN CUTSCENE IS FINISHED
func _on_cs_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "CS_drinking_potion":
		player.position = player_position
		cs_character.position = Vector3(-3.163, 0.294, -6.411)
		get_tree().paused = false
		ui.visible = true
		fade_out.visible = false
		player_camera.make_current()
		blue_potion.visible = false
		pink_potion.visible = false
		yellow_potion.visible = false
		cutscenes_UI.visible = false
		if cauldron.which_potion == "yellow_potion":
			yellow_light_2.visible = true
	
	if anim_name == "CS_right_potion":
		get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	if anim_name == "CS_fast_potion":
		get_tree().change_scene_to_file("res://Scenes/game_over_menu.tscn")
	if anim_name == "CS_slow_potion":
		get_tree().change_scene_to_file("res://Scenes/game_over_menu.tscn")
	if anim_name == "CS_no_potion":
		get_tree().change_scene_to_file("res://Scenes/game_over_menu.tscn")
