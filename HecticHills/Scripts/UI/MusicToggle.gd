extends TextureButton

var clicker 
var music

func _ready():
	music = find_parent("Menus").find_node("TitleMusic")
	clicker = find_parent("Menus").find_node("Click")
	pressed = GameManager.musicMuted

func _on_MusicToggle_pressed():
	GameManager.musicMuted = pressed
	if not GameManager.musicMuted:
		music.playTrack()
	if GameManager.musicMuted:
		music.volume_db = -60
	if not GameManager.soundMuted: 
		clicker.playing = true
