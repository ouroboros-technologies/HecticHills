extends Control



func _on_EndPopUp_visibility_changed():
	find_node("Score").text = "You Scored: " + str(GameManager.score)
	find_node("GoldCollected").text = "Gold Collected: " + str(GameManager.gold)
