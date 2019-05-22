extends Label

func _process(delta):
	text = "Gold cost: " + str(GameManager.four_wheel_drive * 1000)