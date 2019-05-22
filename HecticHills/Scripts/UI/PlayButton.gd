extends TextureButton

var clicker

func _ready():
	clicker = get_parent().get_parent().get_parent().find_node("Click")

func _on_PlayButton_pressed():
	if not GameManager.soundMuted: 
		clicker.playing = true
	yield(get_tree().create_timer(0.1), "timeout")
	GameManager.setScene("res://Scenes/Terrain.tscn")