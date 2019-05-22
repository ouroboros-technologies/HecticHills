extends TextureButton

var clicker 

func _ready():
	clicker = find_parent("Menus").find_node("Click")

func _on_Options_pressed():
	find_parent("MainMenuTab").visible = false
	find_parent("Menus").find_node("OptionsMenuTab").visible = true
	if not GameManager.soundMuted: 
		clicker.playing = true
