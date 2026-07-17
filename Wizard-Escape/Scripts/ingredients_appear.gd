extends Node3D

@export var item: ItemData
const INGREDIENT = preload("uid://bhamlfimdgmnn")
#var position_ingredient := [Vector3(4.94, 0.606, 2.848), Vector3(8.546, 0.744, -4.099), Vector3(0.217, 0.946, 3.662), Vector3(-0.067, 1.246, -2.7), Vector3(3.166, 0.071, -1.471), Vector3(-5.047, 0.514, -3.465), Vector3(-7.421, 0.605, 4.185), Vector3(-5.627, 1.023, 6.914), Vector3(-2.472, 0.917, 4.002), Vector3(-13.746, 1.077, 1.562), Vector3(-9.315, 0.918, 4.14), Vector3(-9.983, 1.264, -2.954)]

#FOR TESTS
var position_ingredient := [Vector3(-5.487, 0.0, -1.127), Vector3(-4.711, 0.0, -1.127), Vector3(-3.844, 0.0, -1.127)]

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
