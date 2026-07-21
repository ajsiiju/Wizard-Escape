extends Node3D

var is_open: bool = false

@onready var cauldron_ui : Panel = get_parent().get_node("inventoryTimer/Cauldron")
@onready var ing_slot_1: Panel = get_parent().get_node("inventoryTimer/Cauldron/MarCon/PotUIBG/MarCon/Slots/MarCon/GridContainer2/IngSlot1")
@onready var ing_slot_1_icon: TextureRect = get_parent().get_node("inventoryTimer/Cauldron/MarCon/PotUIBG/MarCon/Slots/MarCon/GridContainer2/IngSlot1/Icon")
@onready var ing_slot_2: Panel = get_parent().get_node("inventoryTimer/Cauldron/MarCon/PotUIBG/MarCon/Slots/MarCon/GridContainer2/IngSlot2")
@onready var ing_slot_2_icon: TextureRect = get_parent().get_node("inventoryTimer/Cauldron/MarCon/PotUIBG/MarCon/Slots/MarCon/GridContainer2/IngSlot2/Icon")
@onready var potion_slot: TextureRect = get_parent().get_node("inventoryTimer/Cauldron/MarCon/PotUIBG/MarCon/Slots/MarCon2/PotionSlot/Icon")


@export var item: ItemData
@onready var cauldron_normal: Node3D = $RigidBody3D/cauldron_normal
@onready var cauldron_hover: Node3D = $RigidBody3D/cauldron_hover
@onready var big_bubbles_particles: GPUParticles3D = $BigBubblesParticles
@onready var small_bubbles_particles: GPUParticles3D = $SmallBubblesParticles
@onready var blue_highlight := preload("res://Scripts/Recource/object_highlight.tres")
@onready var black_highlight := preload("res://Scripts/Recource/object_highlight_black.tres")


@onready var timer := get_parent().get_node("inventoryTimer/Timer")
var yellow_potion := preload("res://UI/yellow_potion.png")
var pink_potion := preload("res://UI/pink_potion.png")
var blue_potion := preload("res://UI/blue_potion.png")
var which_potion := ""

signal potion_drunk()
signal potion_effect(which_potion: String)


func _ready() -> void:
	$".".potion_effect.connect(get_node("../player")._on_potion_effect)
	timer.end_cutscene.connect(_on_end_cutscene)

func open() -> void:
	if is_open == false:
		cauldron_ui.visible = true
		Input.mouse_mode = Input.MOUSE_MODE_CONFINED
		is_open = true
	elif is_open == true:
		cauldron_ui.visible = false
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		is_open = false

func add_highlight() -> void:
	cauldron_hover.visible = true
	cauldron_normal.visible = false
	big_bubbles_particles.material_overlay = blue_highlight
	small_bubbles_particles.material_overlay = blue_highlight

func remove_highlight() -> void:
	cauldron_normal.visible = true
	cauldron_hover.visible = false
	big_bubbles_particles.material_overlay = black_highlight
	small_bubbles_particles.material_overlay = black_highlight

func _on_drink_button_pressed() -> void:
	if potion_slot.texture != null:
		$UIClick.play()
		potion_slot.texture = null
		cauldron_ui.visible = false
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		is_open = false
		potion_drunk.emit()
		potion_effect.emit(which_potion)


func _on_create_button_pressed() -> void:
	if ing_slot_1.item and ing_slot_2.item and ((ing_slot_1.item.item_name == "Herb" and ing_slot_2.item.item_name == "Eye") or (ing_slot_1.item.item_name == "Eye" and ing_slot_2.item.item_name == "Herb")):
		$UIClick.play()
		potion_slot.texture = blue_potion
		ing_slot_1.item = null
		ing_slot_2.item = null
		
		ing_slot_1_icon.texture = null
		ing_slot_2_icon.texture = null
		
		which_potion = "blue_potion"
	
	if ing_slot_1.item and ing_slot_2.item and ((ing_slot_1.item.item_name == "Herb" and ing_slot_2.item.item_name == "Frog_leg") or (ing_slot_1.item.item_name == "Frog_leg" and ing_slot_2.item.item_name == "Herb")):
		$UIClick.play()
		potion_slot.texture = pink_potion
		ing_slot_1.item = null
		ing_slot_2.item = null
		ing_slot_1_icon.texture = null
		ing_slot_2_icon.texture = null
		which_potion = "pink_potion"
	
	if ing_slot_1.item and ing_slot_2.item and ((ing_slot_1.item.item_name == "Frog_leg" and ing_slot_2.item.item_name == "Eye") or (ing_slot_1.item.item_name == "Eye" and ing_slot_2.item.item_name == "Frog_leg")):
		$UIClick.play()
		potion_slot.texture = yellow_potion
		ing_slot_1.item = null
		ing_slot_2.item = null
		ing_slot_1_icon.texture = null
		ing_slot_2_icon.texture = null
		which_potion = "yellow_potion"

func _on_end_cutscene() -> void:
	if which_potion == "yellow_potion":
		get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	if which_potion == "pink_potion":
		get_tree().change_scene_to_file("res://Scenes/game_over_menu.tscn")
	if which_potion == "blue_potion":
		get_tree().change_scene_to_file("res://Scenes/game_over_menu.tscn")


func _on_interactable_focused(interactor: Interactor) -> void:
	add_highlight()


func _on_interactable_interacted(interactor: Interactor) -> void:
	open()


func _on_interactable_unfocused(interactor: Interactor) -> void:
	remove_highlight()
