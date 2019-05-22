extends TextureButton

var clicker 

func _ready():
	clicker = get_parent().get_parent().get_parent().get_parent().find_node("Click")
	pressed = GameManager.soundMuted

func _on_SoundToggle_pressed():
	GameManager.soundMuted = pressed
	if not GameManager.soundMuted: 
		clicker.playing = true
