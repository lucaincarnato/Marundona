extends CharacterBody2D

# Get the gravity from the project settings to be synced with RigidBody nodes
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var levelSlider = get_node("../../HUD/LevelSlider").get_child(2)
@onready var levelLabel = get_node("../../HUD/LevelSlider").get_child(1)

var marundona : Player = Player.new(get_node("."))	# Instantiate new Marundona to work on its methods

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	move_and_slide()
	marundona.update_level(levelLabel, levelSlider)

func _on_animated_sprite_2d_animation_finished():
	self.marundona.set_animation("run")
