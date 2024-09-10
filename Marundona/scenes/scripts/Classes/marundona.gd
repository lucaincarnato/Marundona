extends Object 

class_name Player

var _node : Node	# Node assigned to the object to modulate its behaviour
# Marundona's information
var level : int

func _init(marundonaScene : Node):
	level = 1
	_node = marundonaScene

# Used to transfer the node to a layer not visible by Enemy
func dribbling_in(scene : SceneTree):
	_node.set_collision_mask_value(1, false)
	_node.set_collision_mask_value(2, true)
	_node.set_collision_layer_value(1, false)
	_node.set_collision_layer_value(2, true)
	# Waits 2 seconds to activate the function
	await scene.create_timer(2).timeout
	dribbling_out()

# Used to get back to the same layer as the enemy
func dribbling_out():
	_node.set_collision_mask_value(2, false)
	_node.set_collision_mask_value(1, true)
	_node.set_collision_layer_value(2, false)
	_node.set_collision_layer_value(1, true)

# Used to update level UI and content
func update_level(label : Node, slider : Node):
	label.text = (str(level))
	if slider.value == slider.max_value:
		level += 1
		slider.max_value += 20
		slider.value = 0

# Used to change animation
func set_animation(animationString : String):
	_node.get_node("AnimatedSprite2D").play(animationString)
