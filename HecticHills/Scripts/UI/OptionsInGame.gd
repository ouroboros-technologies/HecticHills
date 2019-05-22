extends TextureButton


func _on_Options_pressed():
	get_parent().find_node("OptionsInGame").visible = true
	get_tree().paused = true
