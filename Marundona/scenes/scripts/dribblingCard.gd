extends Control

@onready var marundona = get_node("../../../Marundona")
var savedData = load("res://resources/Database.tres")

func _on_button_pressed():
	marundona.play("attack")

