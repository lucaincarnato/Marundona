extends Node2D

var dribbling_scene = preload("res://scenes/prefabs/dribbling.tscn")
@onready var camera = get_node("./Camera2D")
# @onready var stadium = get_node("./Background/Stadium")
@onready var player = get_node("./GameObjects/Marundona")
@onready var ground = get_node("./Ground/AnimationPlayer")
@onready var dribblings = get_node("./HUD/Dribblings")
var savedData = load("res://resources/Database.tres")
	
# Setting up the scene: not in pause, marundona in idle, ground stopped
func _ready():
	get_node("CroudCheer").play()
	savedData.load_data()
	get_tree().paused = false 
	get_node("GameObjects/SpawnTimer").set_paused(true)
	get_node("GameObjects/DribblingTimer").set_paused(true)
	get_node("HUD/Score/ScoreTimer").set_paused(true)
	player.marundona.set_animation("idle")
	ground.pause()

func _process(_delta):
	if (savedData.bribes <= 0):
		get_node("HUD/GameOver/GameOverPanel/VarButton").disabled = true

# Used to pause the match
func _on_pause_button_pressed():
	get_node("GameObjects/SpawnTimer").set_paused(true)
	get_node("GameObjects/DribblingTimer").set_paused(true)
	get_node("HUD/Score/ScoreTimer").set_paused(true)
	$HUD/Pause.show()
	get_tree().paused = true

# Used to resume the match after paused
func _on_resume_button_pressed():
	get_node("GameObjects/SpawnTimer").set_paused(false)
	get_node("GameObjects/DribblingTimer").set_paused(false)
	get_node("HUD/Score/ScoreTimer").set_paused(false)
	$HUD/Pause.hide()
	$HUD/NewDribbling.hide()
	get_tree().paused = false

# Used to go to menu after paused the match
func _on_p_menu_button_pressed():
	get_node("GameObjects/SpawnTimer").set_paused(true)
	get_node("GameObjects/DribblingTimer").set_paused(true)
	get_node("HUD/Score/ScoreTimer").set_paused(true)
	get_tree().change_scene_to_file("res://scenes/main.tscn")
	get_node("./HUD/Score").set_high_score()
	savedData.saving()

func _on_menu_button_pressed():
	get_node("GameObjects/SpawnTimer").set_paused(false)
	get_node("GameObjects/DribblingTimer").set_paused(false)
	get_node("HUD/Score/ScoreTimer").set_paused(false)
	get_tree().change_scene_to_file("res://scenes/main.tscn")
	get_node("./HUD/Score").set_high_score()
	savedData.saving()

func _on_var_button_pressed():
	player.marundona.dribbling_in(get_tree())
	get_node("GameObjects/SpawnTimer").set_paused(false)
	get_node("GameObjects/DribblingTimer").set_paused(false)
	get_node("HUD/Score/ScoreTimer").set_paused(false)
	$HUD/GameOver.hide()
	get_tree().paused = false
	savedData.bribes -= 1

# Used to change scene to look at the career 
func _on_career_button_pressed():
	get_node("GameObjects/SpawnTimer").set_paused(true)
	get_node("GameObjects/DribblingTimer").set_paused(true)
	get_node("HUD/Score/ScoreTimer").set_paused(true)
	camera.set_motion("career")
	# stadium.set_motion("career")

func _on_options_pressed():
	get_node("GameObjects/SpawnTimer").set_paused(true)
	get_node("GameObjects/DribblingTimer").set_paused(true)
	get_node("HUD/Score/ScoreTimer").set_paused(true)
	camera.set_motion("options")
	savedData.saving()

# Used to start the game sliding camera and showing HUD
func _on_start_button_pressed():
	get_node("GameObjects/SpawnTimer").set_paused(false)
	get_node("GameObjects/DribblingTimer").set_paused(false)
	get_node("HUD/Score/ScoreTimer").set_paused(false)
	camera.set_motion("match")
	# stadium.set_motion("match")
	$StartingHUD.hide()
	$HUD.show()
	player.marundona.set_animation("run")
	ground.play()

