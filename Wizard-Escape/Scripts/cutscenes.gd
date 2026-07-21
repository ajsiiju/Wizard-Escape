extends Node3D

var player_position := Vector3()
@onready var player: CharacterBody3D = $"../player"
@onready var player_camera: Camera3D = $"../player/CameraRig/Camera3D"

@onready var cauldron: Node3D = $"../Cauldron"
@onready var ui: CanvasLayer = $"../inventoryTimer"


@onready var cs_player: AnimationPlayer = $CSPLayer
@onready var cs_camera: Camera3D = $CSCamera


func _ready() -> void:
	cauldron.potion_drunk.connect(_on_potion_drunk)



func _on_potion_drunk() -> void:
	player_position = player.position
	player.position = Vector3(-3.163, 0.294, -7.252)
	cauldron.remove_highlight()
	get_tree().paused = true
	ui.visible = false
	cs_camera.make_current()
	cs_player.play("CS_drinking_potion_blue")



func _on_cs_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "CS_drinking_potion_blue":
		player.position = player_position
		get_tree().paused = false
		ui.visible = true
		player_camera.make_current()
