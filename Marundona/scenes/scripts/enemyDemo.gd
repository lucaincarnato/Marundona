extends CharacterBody2D

const SPEED = -10000.0

var enemyObject : Enemy	# Enemy istance used to access its behaviour
@onready var player = get_parent().get_node("Marundona")
@onready var dribblings = get_node("../../HUD/Dribblings")
@onready var score_label = get_node("../../HUD/Score")
var savedData = load("res://resources/Database.tres")
# Get the gravity from the project settings to be synced with RigidBody nodes
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	velocity.x = SPEED * delta
	move_and_slide()
	# Collision system implementation
	for i in get_slide_collision_count():
		var collision = enemyObject.get_enemy().get_slide_collision(i)
		if(collision.get_collider().name == "Marundona"):	# Gets marundona's level and actual type for the comparison
			var mLevel : int = player.marundona.level
			var mType : String = dribblings.get_buffer()
			# hasCollided = true means marundona didn't dribbled the enemy
			if enemyObject.check_collision(mType, mLevel):
				get_node("../../HUD/GameOver").show()
				get_tree().paused = true
				savedData.saving()
			else: 
				player.marundona.dribbling_in(get_tree())
				dribblings.set_buffer("")
				if !savedData.dribbledEnemies.has(enemyObject.index): savedData.dribbledEnemies.append(enemyObject.index)

# Used to instantiate Enemy on spawn 
func set_spawn_node(eindex : int, enemy : String, level : int, type : String, rarity : int, actualNode : Node, startingPosition : Vector2):
	enemyObject = Enemy.new()
	enemyObject.index = eindex
	enemyObject.name = enemy
	enemyObject.level = level
	enemyObject.type = type
	enemyObject.rarity = rarity
	enemyObject.set_node(actualNode, startingPosition)

# Deleting the object after it goes off the screen
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
