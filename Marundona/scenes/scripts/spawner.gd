extends Node2D

var savedData = load("res://resources/Database.tres")
var enemyPrefab = preload("res://scenes/prefabs/enemyPrefab.tscn")
var dribblingPrefab = preload("res://scenes/prefabs/dribbling.tscn")
# Indexes to set the rarity into the random extraction
var commonRange : int = savedData.enemiesRarity.count(0) - 1
var rareRange : int = commonRange + savedData.enemiesRarity.count(1)
var epicRange : int = rareRange + savedData.enemiesRarity.count(2)
var leggendaryRange : int = epicRange + savedData.enemiesRarity.count(3)
# Parameters used to update enemies' level each five spawns
var levelTick : int = 0
var enemyLevel : int = 1

func _on_spawn_timer_timeout():
	# Counter to increase enemies' level 
	levelTick += 1
	if levelTick == 5: 
		enemyLevel += 1
		levelTick = 0
	# Instantiate and set up the enemy
	var _spawnedEnemy = enemyPrefab.instantiate()
	var _spawnPosition = Vector2(randf_range(800,1000), 0)
	var _index = rand_extraction()
	var _name = savedData.enemiesName[_index]
	var _level = enemyLevel
	var _type = savedData.enemiesType[_index]
	var _rarity = savedData.enemiesRarity[_index]
	_spawnedEnemy.name = _name
	_spawnedEnemy.set_spawn_node(_index, _name, _level, _type, _rarity, _spawnedEnemy, _spawnPosition)
	get_node(".").add_child(_spawnedEnemy)

func _on_dribbling_timer_timeout():
	# Instantiate the dribbling node
	var dribbling = dribblingPrefab.instantiate()
	dribbling.position = Vector2(randf_range(700,1000), 0)
	get_node(".").add_child(dribbling)

# Used to extract a random index between 0 and enemies.size() - 1 according to rarity percentage: 
	# Common 45% -> 6
	# Rare 30% -> 4
	# Epic 20% -> 3
	# Leggendary 5% -> 1
# The probability of spawning the leggendary is even lower than 5%
func rand_extraction() -> int:
	var randHundred = randi_range(0,99)
	# 45% -> extracts only common
	if(randHundred < 45):
		return randi_range(0,commonRange)
	# 30% -> extracts common and rare 
	elif(randHundred >= 45 && randHundred < 75):
		return randi_range(0,rareRange)
	# 20% -> extracts common, rare and epic
	elif(randHundred >= 75 && randHundred < 95):
		return randi_range(0,epicRange)
	# 5% -> extracts common, rare, epic and leggendary (all)
	else: 
		return randi_range(0,leggendaryRange)
