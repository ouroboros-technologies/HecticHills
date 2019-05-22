extends TextureButton

var clicker 
var credits

func _ready():
	clicker = get_parent().get_parent().get_parent().find_node("Click")
	credits = get_parent().get_parent().get_parent().find_node("CreditsTab")

func _on_Credits_pressed():
	credits.visible = not credits.visible
	if not GameManager.soundMuted: 
		clicker.playing = true