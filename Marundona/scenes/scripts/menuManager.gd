extends Node2D

@onready var camera = get_node("./Camera2D")
var savedData = load("res://resources/Database.tres")

func _ready():
	get_tree().paused = false	# The game starts not paused

# Changes scene once play is pressed 
func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")
