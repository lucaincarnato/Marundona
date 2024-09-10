extends Camera2D

var isMoving : bool	# Check if the camera is moving or not
var interpolationVariable = 0	# Variable of interpolation
var targetPosition : Vector2 # Buffer
@onready var stadium = get_node("../Background/Stadium")

func _ready():
	isMoving = false
	position = Vector2(-600, 0)

func _process(delta):
	if (isMoving): 
		interpolationVariable += delta * 0.3
		position = position.lerp(targetPosition, interpolationVariable)
	if (position == targetPosition):
		isMoving = false
		stadium.isMoving = true
		get_tree().paused = false 

# Used to comand the camera to move
func set_motion(what : String):
	if(what == "match"):
		interpolationVariable = 0
		targetPosition = Vector2(0,0)
		stadium.isMoving = true
	elif(what == "career"): 
		interpolationVariable = 0
		targetPosition = Vector2(-600,676)
	elif(what == "options"): 
		interpolationVariable = 0
		targetPosition = Vector2(-600,-649)
	elif(what == "main"):
		interpolationVariable = 0
		targetPosition = Vector2(-600, 0)
	elif(what == "goal"): 
		interpolationVariable = 0
		targetPosition = Vector2(1083,0)
		stadium.isMoving = true
	isMoving = true
