extends TextureButton

var clicker

func _ready():
	clicker = get_parent().get_parent().get_parent().get_parent().find_node("Click")

func _on_OptionsBackButton2_pressed():
	find_parent("CreditsTab").visible = false
	find_parent("Menus").find_node("OptionsMenuTab").visible = true
	if not GameManager.soundMuted: 
		clicker.playing = true

