extends AnimationTree

signal toggled
@onready var animation_tree = self


func _ready():
	active = true

func _on_toggle_button_toggled(button_pressed):
	if button_pressed:
		animation_tree["parameters/playback"].start("toggleOff")
		await get_tree().create_timer(0.35).timeout
		emit_signal("toggled")
	else:
		animation_tree["parameters/playback"].travel("toggleOn")
		await get_tree().create_timer(0.35).timeout
		emit_signal("toggled")
