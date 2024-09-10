extends Enemy 

class_name CareerCard

var assignedNode : Node	# Node assigned to the object to modulate its behaviour

func set_node(_assignedPrefab, startingPosition : Vector2):
	_node.position = startingPosition
	_node.get_node("Panel").self_modulate = "6CACE4"
	_node.get_node("NameLabel").text = name
	_node.get_node("Type/TypeLabel").text = type
	_node.get_node("Type/TypePanel").self_modulate = color_type()
	_node.get_node("AnimatedSprite2D").material.set("shader_param/line_color", color_rarity())

func set_enemy(assignedPrefab):
	_node = assignedPrefab.instantiate()
