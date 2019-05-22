extends Label

func _process(delta):
	text = "Gold cost: " +  str(GameManager.engine_level * 1000)