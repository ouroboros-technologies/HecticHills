extends TextureButton

var clicker 
var music

func _ready():
	music = get_parent().get_parent().get_parent().get_parent().find_node("TitleMusic")
	clicker = get_parent().get_parent().get_parent().get_parent().find_node("Click")
	pressed = GameManager.musicMuted

func _on_MusicToggle_pressed():
	GameManager.musicMuted = pressed
	if not GameManager.musicMuted:
		if not music.playing:
			music.playTrack()
		music.volume_db = GameManager.musicVolume
	if GameManager.musicMuted:
		music.volume_db = -60
	if not GameManager.soundMuted: 
		clicker.playing = true
