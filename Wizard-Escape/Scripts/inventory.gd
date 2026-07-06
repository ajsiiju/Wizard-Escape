extends Panel

var data_bk: Control
func _notification(what: int) -> void:
	if what == Node.NOTIFICATION_DRAG_BEGIN:
		data_bk = get_viewport().gui_get_drag_data()
	
	if what == Node.NOTIFICATION_DRAG_END:
		if not is_drag_successful():
			if data_bk:
				data_bk.icon.show()
				data_bk = null

func _on_ingredient_picked(picked_item: ItemData) -> void:
	for slot in $MarginContainer/TextureRect/GridContainer.get_children():
		if slot.item == null:
			slot.item = picked_item
			slot.update_ui()
			return
