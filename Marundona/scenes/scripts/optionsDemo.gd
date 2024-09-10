extends Control

var savedData = load("res://resources/Database.tres")
@onready var camera = get_parent().get_node("Camera2D")

func _on_g_menu_button_pressed():
	camera.set_motion("main")
	print_debug(camera)
	savedData.saving()

func _on_reset_progress_button_pressed():
	savedData.highScore = 0
	savedData.dribbledEnemies = []
	savedData.dribblingsObtained = [0,1,2,3]
	savedData.saving()
	get_tree().change_scene_to_file("res://scenes/main.tscn")
