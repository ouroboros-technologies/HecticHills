extends TextureButton

var clicker

func _ready():
	clicker = find_parent("Node2D").find_node("Click")

func _on_Unpause_pressed():
	get_tree().paused = false
	find_parent("OptionsInGame").visible = false
	if not GameManager.soundMuted: 
		clicker.playing = true
