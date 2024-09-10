extends Control

var interpolationVariable : float = 0.0
var isMoving : bool = false
var targetPosition:Vector2 = Vector2(480,-170)
var startingPosition:Vector2 = Vector2(650,-170)


func _process(delta):
	# Move the panel when it is called move or back function
	if (isMoving): 
		interpolationVariable += delta 
		global_position = global_position.lerp(targetPosition, interpolationVariable)
	elif(!isMoving && global_position != startingPosition): 
		interpolationVariable += delta 
		global_position = global_position.lerp(startingPosition, interpolationVariable)


# Used to slide in the panel
func move(type):
	interpolationVariable = 0
	isMoving = true
	match type:
		"AGG":
			get_node("./Agg").show()
		"TKN":
			get_node("./Tkn").show()
		"INT":
			get_node("./Int").show()
		"PHY":
			get_node("./Phy").show()

# Used to slide out the panel
func back():
	interpolationVariable = 0
	isMoving = false
	await get_tree().create_timer(1).timeout
	get_node("./Agg").hide()
	get_node("./Tkn").hide()
	get_node("./Int").hide()
	get_node("./Phy").hide()
