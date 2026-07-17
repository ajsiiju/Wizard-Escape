extends Panel

@onready var icon: TextureRect = $Icon
@export var item: ItemData
const INGREDIENT := preload("uid://dqbhg13pkrc82")



func _ready() -> void:
	Input.set_custom_mouse_cursor(load("res://UI/kursor2.png"), Input.CURSOR_CAN_DROP)
	Input.set_custom_mouse_cursor(load("res://UI/kursor2.png"), Input.CURSOR_FORBIDDEN)
	update_ui()


func update_ui() -> void:
	if not item:
		icon.texture = null
		return
	icon.texture = item.icon


func _get_drag_data(at_position: Vector2) -> Variant:
	if not item:
		return
	
	var preview := duplicate()
	var c := Control.new()
	c.add_child(preview)
	c.z_index = 1
	preview.position -= Vector2(25, 25)
	set_drag_preview(c)
	icon.hide()
	return self


#CHECKS WHAT CAN BE IN A SLOT
func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return true


func _drop_data(at_position: Vector2, data: Variant) -> void:
	var tmp := item
	item = data.item
	data.item = tmp
	icon.show()
	data.icon.show()
	update_ui()
	data.update_ui()
