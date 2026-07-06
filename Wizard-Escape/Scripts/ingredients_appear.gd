extends Node3D

@export var item: ItemData
const INGREDIENT = preload("uid://bhamlfimdgmnn")
var position_ingredient := [Vector3(0.399, 0.983, 3.428), Vector3(8.36, 0.724, -4.236), Vector3(-13.787, 1.097, 0.259), Vector3(-4.072, 0.045, -4.002), Vector3(7.466, 0.551, 4.773)]
var ingredient := ["res://Scripts/Recource/eye.tres", "res://Scripts/Recource/frog_leg.tres", "res://Scripts/Recource/herb.tres"]
var rng := RandomNumberGenerator.new()

func _ready() -> void:
	for i:String in ingredient:
		var current_resource := load(i)
		var node := INGREDIENT.instantiate()
		node.set_meta("item_data", current_resource)
		node.get_node("MeshInstance3D").mesh = current_resource.mesh
		
		var mat := StandardMaterial3D.new()
		mat.albedo_texture = current_resource.material
		node.get_node("MeshInstance3D").material_override = mat
		
		var random_position := rng.randf_range(0, position_ingredient.size())
		var current_position :Vector3 = position_ingredient[random_position]
		node.position = current_position
		position_ingredient.remove_at(random_position)
		
		node.item = current_resource 
		node.ingredient_pick_up.connect(get_node("../inventoryTimer/Inventory")._on_ingredient_picked)
		node.ingredient_pick_up.connect(get_node("../player")._on_ingredient_picked)

		
		get_tree().current_scene.add_child.call_deferred(node)
