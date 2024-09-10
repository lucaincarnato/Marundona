extends AnimatedSprite2D

var isMoving: bool

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if isMoving:
		position = get_node("../../Camera2D").global_position
