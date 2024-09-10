extends Resource

class_name Database

# High score variable
@export var highScore : int
@export var bribes : int
@export var lastBribesUpdate : float

# Contains all the information about enemies
@export var enemiesName : PackedStringArray = [
	"ZIDANE", 
	"SUAREZ", 
	"MALDINI", 
	"TOTTI", 
	"KOULIBALY", 
	"LUKAKU", 
	"HAALAND",
	"RONALDINHO", 
	"DEL PIERO", 
	"MBAPPE", 
	"RONALDO", 
	"MESSI", 
	"IBRAHIMOVIC", 
	"PELE"
]
@export var enemiesRarity: PackedInt32Array = [
	0,
	0,
	0,
	0,
	0,
	0,
	1,
	1,
	1,
	1,
	2,
	2,
	2,
	3
]
@export var enemiesType : PackedStringArray = [
	"AGG", 
	"AGG", 
	"PHY", 
	"PHY", 
	"PHY", 
	"PHY", 
	"AGG",
	"TKN", 
	"TKN", 
	"PHY", 
	"PHY", 
	"INT", 
	"INT", 
	"TKN"
]

# Contains the index of the dribbled enemies from the arrays above
@export var dribbledEnemies : PackedInt32Array

# Contains the index of the obtained dribblings from the arrays above
@export var dribblingsObtained : PackedInt32Array = [
	0,1,2,3
]

# Contains all the information about dribblings
@export var dribblingsName : PackedStringArray = [
	"Breakthrough", 
	"Step Over", 
	"Sombrero", 
	"Body Feint", 
	"Shot Cancel", 
	"Roulette", 
	"Roll Drag", 
	"Elastico", 
	"Ronaldo Chop", 
	"Rainbow", 
	"Heel to Heel", 
	"Nutmeg", 
	"Mano de Dios"
]
@export var dribblingsType : PackedStringArray = [
	"AGG", 
	"PHY", 
	"TKN", 
	"INT", 
	"AGG", 
	"PHY", 
	"TKN", 
	"INT", 
	"AGG", 
	"PHY", 
	"TKN", 
	"INT", 
	"SUP"
]
@export var dribblingsUses : PackedInt32Array = [
	8,5,4,2, 
	10,5,6,2,10,8,6,2, 
	1
]
@export var dribblingsPoints : PackedInt32Array = [
	10,15,15,20,
	12,20,15,30,15,20,17,40,
	0
]
@export var dribblingsHighScore : PackedInt32Array =[
	0,0,0,0,
	200,600,1000,1500,2000,3500,5000,7500,
	10000
]

# Save the game once exited
func saving():
	var myDatabase = Database.new()
	dribbledEnemies.sort()
	dribblingsObtained.sort()
	myDatabase.highScore = highScore
	myDatabase.bribes = bribes
	myDatabase.lastBribesUpdate = lastBribesUpdate
	myDatabase.enemiesName = enemiesName
	myDatabase.enemiesRarity = enemiesRarity
	myDatabase.enemiesType = enemiesType
	myDatabase.dribbledEnemies = dribbledEnemies
	myDatabase.dribblingsObtained = dribblingsObtained
	myDatabase.dribblingsName = dribblingsName
	myDatabase.dribblingsType = dribblingsType
	myDatabase.dribblingsUses = dribblingsUses
	myDatabase.dribblingsPoints = dribblingsPoints
	ResourceSaver.save(myDatabase, "res://resources/Database.tres")

func load_data():
	var gameData = load("res://resources/Database.tres")
	if gameData:
		# Utilizza i dati di gioco caricati...
		gameData.highScore = highScore
		gameData.bribes = bribes
		gameData.lastBribesUpdate = lastBribesUpdate
		gameData.enemiesName = enemiesName
		gameData.enemiesRarity = enemiesRarity
		gameData.enemiesType = enemiesType
		gameData.dribbledEnemies = dribbledEnemies
		gameData.dribblingsObtained = dribblingsObtained
		gameData.dribblingsName = dribblingsName
		gameData.dribblingsType = dribblingsType
		gameData.dribblingsUses = dribblingsUses
		gameData.dribblingsPoints = dribblingsPoints
	else:
		# Nessuna risorsa trovata, gestisci l'errore...
		return 
