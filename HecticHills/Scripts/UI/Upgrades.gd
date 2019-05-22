extends TextureButton

var clicker 

func _ready():
	clicker = find_parent("Menus").find_node("Click")

func _on_Upgrades_pressed():
	find_parent("MainMenuTab").visible = false
	find_parent("Menus").find_node("UpgradesMenuTab").visible = true
	if not GameManager.soundMuted:
		clicker.playing = true
