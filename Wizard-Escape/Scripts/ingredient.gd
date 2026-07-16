extends RigidBody3D

@export var item: ItemData
signal ingredient_pick_up(data: ItemData)

func add_highlight() -> void:
	$MeshInstance3D.material_overlay = load("res://Scripts/Recource/object_highlight.tres")

func remove_highlight() -> void:
	$MeshInstance3D.material_overlay = load("res://Scripts/Recource/object_highlight_black.tres")


func _on_interactable_focused(interactor: Interactor) -> void:
	add_highlight()


func _on_interactable_interacted(interactor: Interactor) -> void:
	if Input.is_action_pressed("interact"):
		ingredient_pick_up.emit(item)
		queue_free()


func _on_interactable_unfocused(interactor: Interactor) -> void:
	remove_highlight()
