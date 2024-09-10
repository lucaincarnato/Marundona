extends CharacterBody2D

# Dribbling node's speed 
const SPEED = -7.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var dribblingManager = get_node("../../HUD/Dribblings")

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	velocity.x = SPEED * 1000 * delta
	move_and_slide()
	# Implement collision system
	for index in get_slide_collision_count():
		var collision = get_slide_collision(index)
		if(collision.get_collider().name == "Marundona"):
			dribblingManager.add_dribbling()
			queue_free()	# Delete dribbling node when collides with Marundona

# Used to delete Enemy node when it exits the screen
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
