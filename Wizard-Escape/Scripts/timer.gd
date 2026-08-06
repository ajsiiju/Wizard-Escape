extends Panel

@onready var timer := $MarginContainer/TextureRect/ProgressBar
@onready var cauldron := $"../../Cauldron"
@onready var progress_bar: ProgressBar = $MarginContainer/TextureRect/ProgressBar

var active_tween := create_tween()
signal end_cutscene(which_potion: String)

var timer_length := 57
#var timer_length := 1


func _ready() -> void:
	cauldron.potion_drunk.connect(_on_potion_drunk)
	progress_bar.max_value = timer_length
	progress_bar.value = timer_length


func _on_timer_timeout() -> void:
	if timer.value <= 0:
		end_cutscene.emit(cauldron.which_potion)
	else:
		active_tween = create_tween()
		active_tween.tween_property(timer, "value", timer.value - 1, 1.0).set_trans(Tween.TRANS_LINEAR)


func _on_potion_drunk() -> void:
	if timer.value > 5:
		if active_tween:
			active_tween.kill()
		timer.value = 5
