extends Timer

var active_tween := create_tween()
@onready var black_screen: ColorRect = $"../BlackScreen/ColorRect"


func _on_timeout() -> void:
	active_tween = create_tween()
	active_tween.tween_property(black_screen, "color", Color(0.0, 0.0, 0.0, 0.0), 0.5).set_trans(Tween.TRANS_LINEAR)
