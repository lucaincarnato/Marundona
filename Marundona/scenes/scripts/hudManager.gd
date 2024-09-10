extends Control

var score : int = 0
var savedData = load("res://resources/Database.tres")
@onready var camera = get_node("../Camera2D")

func _process(_delta):
	$Score/ScoreLabel.text = (str(score)) + " metres"
	$GameOver/GameOverPanel/ScoreText.text = "Maradona has run " + (str(score)) + " metres"
	$Pause/PausePanel/CurrentScoreText.text = "Maradona has run " + (str(score)) + " metres"

# Used to increment the score once every two seconds
func _on_timer_timeout():
	score += 1

func score_goal():
	# Avvia animazione di goal
	savedData.saving()
	camera.set_motion("goal")
	get_node("Finish").show()
