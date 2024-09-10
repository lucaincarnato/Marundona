extends Control

var buttonList	# DribblingButton's array
var dribblingBuffer : String	# Dribbling type's buffer to communicate with Marundona
var pressingCount : bool	# Count press time to enable focus sliding
@onready var levelSlider = get_node("../../HUD/LevelSlider").get_child(2)
@onready var focusPanel = get_node("../../HUD/FocusPanel")
var savedData = load("res://resources/Database.tres")
@onready var player = get_node("../../GameObjects/Marundona")

func _ready():
	# Istances of DribblingButtons
	var firstButton : DribblingButton = DribblingButton.new(get_node("DribblingButton0"), Dribbling.new(0))
	var secondButton : DribblingButton = DribblingButton.new(get_node("DribblingButton1"), Dribbling.new(1))
	var thirdButton : DribblingButton = DribblingButton.new(get_node("DribblingButton2"), Dribbling.new(2))
	var fourthButton : DribblingButton = DribblingButton.new(get_node("DribblingButton3"), Dribbling.new(3))
	# Associate buttons objects, dribblings objects and array
	buttonList = [firstButton, secondButton, thirdButton, fourthButton]
	for i in buttonList.size():
		buttonList[i].new_dribbling(Dribbling.new(savedData.dribblingsObtained[randi_range(0, savedData.dribblingsObtained.size() - 1)]))

func _process(_delta):
	# Update the buttons' text each frame
	for i in buttonList.size():
		buttonList[i].update_button()
		if buttonList[i].dribbling.type == "SUP": 
			buttonList[i].dribbling.points = levelSlider.max_value

# Used to add dribbling if one slot is available
func add_dribbling():
	var i = 0
	while i != buttonList.size():
		if buttonList[i].get_button().disabled:
			buttonList[i].new_dribbling(Dribbling.new(savedData.dribblingsObtained[randi_range(0, savedData.dribblingsObtained.size() - 1)]))
			i = buttonList.size()
		else: 
			i += 1

# Used to update usages, xp points and buffer once button is pressed
func update_dribbling(pointer : int):
	buttonList[pointer].dribbling.uses -= 1
	levelSlider.value += buttonList[pointer].dribbling.points
	focusPanel.back()
	pressingCount = false	# Exit focus if button is not pressed for enaugh time
	dribblingBuffer = buttonList[pointer].dribbling.type
	buttonList[pointer].disable_button()

# Setter for the buffer
func set_buffer(value):
	dribblingBuffer = value

# Getter for the buffer
func get_buffer() -> String:
	return dribblingBuffer

# Used to show panel when button is pressed
func focus_enabling(pointer):
	pressingCount = true	
	await get_tree().create_timer(1).timeout	# Waits one second before starting sliding focus panel
	if pressingCount: 
		focusPanel.move(buttonList[pointer].dribbling.type)
		pressingCount = false

# Signals for dribbling uses
func _on_dribbling_button_0_pressed():
	player.marundona.set_animation("attack")
	get_node("./DribblingButton0").release_focus()
	update_dribbling(0)
	#await get_tree().create_timer(0.75).timeout
	#player.marundona.set_animation("run")

func _on_dribbling_button_1_pressed():
	player.marundona.set_animation("attack")
	get_node("./DribblingButton1").release_focus()
	update_dribbling(1)
	#await get_tree().create_timer(0.75).timeout
	#player.marundona.set_animation("run")

func _on_dribbling_button_2_pressed():
	player.marundona.set_animation("attack")
	get_node("./DribblingButton2").release_focus()
	update_dribbling(2)
	#await get_tree().create_timer(0.75).timeout
	#player.marundona.set_animation("run")

func _on_dribbling_button_3_pressed():
	player.marundona.set_animation("attack")
	get_node("./DribblingButton3").release_focus()
	update_dribbling(3)
	#await get_tree().create_timer(0.75).timeout
	#player.marundona.set_animation("run")

# Signals for focus use
func _on_dribbling_button_0_focus_entered():
	focus_enabling(0)

func _on_dribbling_button_1_focus_entered():
	focus_enabling(1)

func _on_dribbling_button_2_focus_entered():
	focus_enabling(2)

func _on_dribbling_button_3_focus_entered():
	focus_enabling(3)

