extends Control

var savedData = load("res://resources/Database.tres")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	get_node("BribesText").text = str(savedData.bribes)
	if (Time.get_unix_time_from_system() - savedData.lastBribesUpdate >= 86000):
		savedData.bribes = 3
		savedData.lastBribesUpdate = Time.get_unix_time_from_system()
	if (savedData.bribes <= 0):
		get_node("BribesText").text = "0"
