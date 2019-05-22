extends Label


func _process(delta):
	text = "Gold cost: " +  str(GameManager.suspension_level * 1000)
