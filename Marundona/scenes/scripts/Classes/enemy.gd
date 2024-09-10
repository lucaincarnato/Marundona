class_name Enemy

var _node : Node	# Node assigned to the object to modulate its behaviour
# Enemy information
var index : int
var name : String
var level : int
var type : String
var rarity : int

# Set Enemy info in order to allow its behaviours 
func set_node(assignedNode : Node, startingPosition : Vector2):
	_node = assignedNode
	_node.position = startingPosition
	_node.get_node("EnemyUI/NameLabel").text = name
	_node.get_node("EnemyUI/LevelLabel").text = (str(level))
	_node.get_node("EnemyUI/Type/TypeLabel").text = type
	_node.get_node("EnemyUI/Type/TypePanel").self_modulate = color_type()
	_node.get_node("AnimatedSprite2D").material.set("shader_param/line_color", color_rarity())

# Getter for the node
func get_enemy() -> Node:
	return _node

# Used to check the rule of dribbling with Marundona
func check_collision(playerType : String, playerLevel : int) -> bool:
	if playerType == type && playerLevel >= level: 
		return false
	elif playerType == "TKN" && (type == "AGG" || type == "PHY"): 
		return false
	elif playerType == "INT" && type != "INT":
		return false
	elif playerType == "PHY" && type == "AGG":
		return false
	elif playerType == "SUP": 
		return false
	else: 
		return true

# Used to change outline color based on the rarity
func color_rarity() -> Color:
	var shaderColor : Color 
	match rarity:
		0:
			shaderColor = Color("#FFFFFF")
		1:
			shaderColor = Color("#CDA434") 
		2:
			shaderColor = Color("#8F00FF")
		3:
			shaderColor = Color("D6006E")
		_:
			shaderColor = Color("000000")
	return shaderColor

# Used to change the background color of type box
func color_type() -> Color:
	var bgColor:Color 
	match type:
		"AGG":
			bgColor = Color("FFFF00")
		"TKN":
			bgColor = Color("#FF0000") 
		"INT":
			bgColor = Color("#0000FF")
		"PHY":
			bgColor = Color("00FF00")
		_:
			bgColor = Color("999999")
	return bgColor
