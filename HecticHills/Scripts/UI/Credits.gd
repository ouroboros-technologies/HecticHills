extends TextureButton

var clicker 
var credits

func _ready():
	clicker = find_parent("Menus").find_node("Click")
	credits = find_parent("Menus").find_node("CreditsTab")

func _on_Credits_pressed():
	credits.visible = not credits.visible
	if not GameManager.soundMuted: 
		clicker.playing = true