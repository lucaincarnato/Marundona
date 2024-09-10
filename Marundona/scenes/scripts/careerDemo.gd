extends Control

var savedData = load("res://resources/Database.tres")
var cardPrefab = preload("res://scenes/prefabs/careerCard.tscn")
var dribblingPrefab = preload("res://scenes/prefabs/dribblingCard.tscn")
@onready var camera = get_parent().get_node("Camera2D")
@onready var title = get_node("TitleLabel")
@onready var animationTree = get_node("./ToggleButton/AnimationTree")
var mode : bool	# False = enemies, True = dribbling

func _ready():
	animationTree.toggled.connect(_on_toggled)
	mode = true
	for i in savedData.dribblingsHighScore.size(): 
		if(savedData.highScore >= savedData.dribblingsHighScore[i]) && (i not in savedData.dribblingsObtained):
			savedData.dribblingsObtained.append(i)
	determineEnemies()
	determineDribblings()

func _process(_delta):
	if(mode):
		showDribblings()
	else: 
		showEnemies()

func showDribblings(): 
	get_node("Enemies").hide()
	title.text = "Dribblings"
	get_node("Dribblings").show()
	get_node("ScoreScrollContainer/HBoxContainer/Control/ProgressBar").value = savedData.highScore
	get_node("HighScoreLabel").text = "High score: " + str(savedData.highScore) + " metres"

func showEnemies(): 
	get_node("Dribblings").hide()
	title.text = "Enemies"
	get_node("Enemies").show()

func determineEnemies():
	var listNodes = []
	for i in savedData.enemiesName:
		# Set Card's information
		var _enemyCard = CareerCard.new()
		_enemyCard.set_enemy(cardPrefab)
		listNodes.append(_enemyCard)
		get_node("Enemies/EnemyScrollContainer/HBoxContainer").add_child(_enemyCard.get_enemy())
	for i in savedData.enemiesName.size():
		if savedData.dribbledEnemies.has(i):
			listNodes[i].name = savedData.enemiesName[i]
			listNodes[i].type = savedData.enemiesType[i]
			listNodes[i].rarity = savedData.enemiesRarity[i]
			listNodes[i].set_node(cardPrefab, Vector2(0, 0))

func determineDribblings():
	var listNodes = []
	for i in savedData.dribblingsName:
		var _dribblingNode : Node = dribblingPrefab.instantiate()
		_dribblingNode.name = i
		listNodes.append(_dribblingNode)
		get_node("Dribblings/DribblingScrollContainer/VBoxContainer").add_child(_dribblingNode)
	for i in savedData.dribblingsName.size():
		if savedData.dribblingsObtained.has(i):
			var dribbling = DribblingButton.new(listNodes[i], Dribbling.new(i))
			dribbling.set_button(listNodes[i], Vector2(0,0))
			listNodes[i].get_node("./Panel").self_modulate = "6CACE4"
			listNodes[i].get_node("./Button").disabled = false
		else: 
			listNodes[i].get_node("./NameLabel").text = "  Unlock at " + (str(savedData.dribblingsHighScore[i]))
			listNodes[i].get_node("./Button").disabled = true

# Changes back the scene to menu
func _on_g_menu_button_pressed():
	camera.set_motion("main")
	savedData.saving()

func _on_toggled():
	mode = !mode

func _on_marundona_animation_finished():
	get_node("./Dribblings/Marundona").play("idle")
