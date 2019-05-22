extends TextureButton

func _on_MainMenu_pressed():
	get_tree().paused = false
	GameManager.setScene("res://Scenes/MainMenu.tscn")
