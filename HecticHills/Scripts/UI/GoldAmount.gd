extends Label

func _process(delta):
	text = "Gold: " + str(GameManager.gold)