extends TextureButton

var clicker 

func _ready():
	clicker = find_parent("Menus").find_node("Click")
	pressed = GameManager.soundMuted

func _on_SoundToggle_pressed():
	GameManager.soundMuted = pressed
	if not GameManager.soundMuted: 
		clicker.playing = true
