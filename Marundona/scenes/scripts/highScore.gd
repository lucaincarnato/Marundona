extends Control

@onready var label = get_node("./ScoreLabel")
var savedData = load("res://resources/Database.tres")

func _process(_delta):
	check_for_new_dribbling()

# Getter for the high score
func get_high_score() -> int:
	return savedData.highScore

# Setter for the high scpore
func set_high_score():
	if (int(label.text) > int(get_high_score())): 
		savedData.highScore = int(label.text)

func check_for_new_dribbling():
	for i in savedData.dribblingsHighScore.size(): 
		if(int(label.text) >= savedData.dribblingsHighScore[i]) && (i not in savedData.dribblingsObtained):  # && (int(label.text) < 10000)
			savedData.dribblingsObtained.append(i)
			get_tree().paused = true
			get_node("../NewDribbling").show()
			get_node("../NewDribbling/NewDribblingPanel/ScoreText").text = "Marundona unlocked " + savedData.dribblingsName[i]
		# if(int(label.text) == 10000):
			# get_node("../").score_goal()
