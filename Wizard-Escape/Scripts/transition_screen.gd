extends CanvasLayer
var active_tween := create_tween()
@onready var color_rect: ColorRect = $ColorRect


func change_scene_smooth(target_scene_path: String) -> void:
	
	get_tree().change_scene_to_file(target_scene_path)
	
	await get_tree().process_frame
	await get_tree().process_frame
	
	active_tween = create_tween()
	active_tween.tween_property(color_rect, "color", Color(0.0, 0.0, 0.0, 0.0), 0.5).set_trans(Tween.TRANS_LINEAR)
