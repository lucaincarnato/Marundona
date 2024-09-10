extends Object

class_name Dribbling

# Dribbling information
var name : String 
var type : String 
var uses : int 
var points : int 
var savedData = load("res://resources/Database.tres")	# Used only to get actual dribbing's info

func _init(index : int):
	name = savedData.dribblingsName[index]
	type = savedData.dribblingsType[index]
	uses = savedData.dribblingsUses[index]
	points = savedData.dribblingsPoints[index]
