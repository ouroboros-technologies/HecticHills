extends Label

func _process(delta):
	text =  "Gold cost: " + str(GameManager.speed_level * 1000)