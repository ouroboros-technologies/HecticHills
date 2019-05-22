extends TextureButton

var clicker

func _ready():
	print("Clickercalled to set")
	clicker = find_parent("Menus").find_node("Click")

func _on_PlayButton_pressed():
	if not GameManager.soundMuted: 
		clicker.playing = true
	yield(get_tree().create_timer(0.1), "timeout")
	GameManager.setScene("res://Scenes/Terrain.tscn")