extends Panel

@onready var timer := $MarginContainer/TextureRect/ProgressBar
@onready var cauldron := $"../../Cauldron"
var active_tween := create_tween()

func _ready() -> void:
	cauldron.potion_drunk.connect(_on_potion_drunk)

func _on_timer_timeout() -> void:
	if timer.value <= 0:
		get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	else:
		active_tween = create_tween()
		active_tween.tween_property(timer, "value", timer.value - 1, 1.0).set_trans(Tween.TRANS_LINEAR)

func _on_potion_drunk() -> void:
	if timer.value > 5:
		if active_tween:
			active_tween.kill()
		timer.value = 5
