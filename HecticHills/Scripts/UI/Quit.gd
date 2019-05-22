extends TextureButton

var clicker

func _ready():
	clicker = get_parent().get_parent().get_parent().find_node("Click")

func _on_Quit_pressed():
	GameManager.saveGameLocal()
	if not GameManager.soundMuted: 
		clicker.playing = true
	yield(get_tree().create_timer(0.5), "timeout")
	get_tree().quit() # default behavior
