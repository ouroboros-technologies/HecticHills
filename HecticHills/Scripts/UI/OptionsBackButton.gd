extends TextureButton

var clicker

func _ready():
	clicker = get_parent().get_parent().get_parent().find_node("Click")

func _on_OptionsBackButton_pressed():
	find_parent("OptionsMenuTab").visible = false
	find_parent("Menus").find_node("MainMenuTab").visible = true
	if not GameManager.soundMuted: 
		clicker.playing = true