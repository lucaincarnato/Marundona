extends Object

class_name DribblingButton

var _node : Node	# Node assigned to the object to modulate its behaviour
var dribbling : Dribbling	# Dribbling assigned to the Button

func _init(actualNode : Node, actualDribbling : Dribbling):
	_node = actualNode
	dribbling = actualDribbling

# Used to update the Button UI each frame
func update_button():
	_node.get_node("./NameLabel").text = "  " + dribbling.name  #Change with get_node()
	if dribbling.type == "SUP": 
		_node.get_node("./XPLabel").text = "+1 LVL"
	else: 
		_node.get_node("./XPLabel").text = (str(dribbling.points)) + " XP"
	_node.get_node("./Usage").get_child(1).text = (str(dribbling.uses))
	_node.get_node("./Type").get_child(1).text = dribbling.type
	_node.get_node("./Type").get_child(0).self_modulate = change_background_color(dribbling.type)

# Used to add Dribbling when collided with node dribbilng
func new_dribbling(newDribbling : Dribbling):
	dribbling = newDribbling
	_node.disabled = false
	_node.get_child(3).get_child(0).self_modulate = Color("#FFB81C")
	_node.get_child(0).hide()

# Used to access the Node
func get_button() -> Node:
	return _node

func set_button(assignedNode : Node, startingPosition : Vector2): 
	_node = assignedNode
	_node.position = startingPosition
	update_button()

# Used to disable Button UI when uses are 0
func disable_button():
	if dribbling.uses == 0: 
		_node.disabled = true 
		dribbling.name = " "
		dribbling.type = " "
		dribbling.uses = 0
		dribbling.points = 0
		_node.get_child(4).get_child(0).self_modulate = Color("#999999")
		_node.get_child(3).get_child(0).self_modulate = Color("#FF0000")
		_node.get_child(0).show()

# Used to change the background color of type box
func change_background_color(dribblingType : String) -> Color:
	var bgColor:Color 
	match dribblingType:
		"AGG":
			bgColor = Color("FFFF00")
		"TKN":
			bgColor = Color("#FF0000") 
		"INT":
			bgColor = Color("#0000FF")
		"PHY":
			bgColor = Color("00FF00")
		"SUP": 
			bgColor = Color("FFFFFF")
		_:
			bgColor = Color("999999")
	return bgColor
