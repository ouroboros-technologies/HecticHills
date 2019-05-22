extends AudioStreamPlayer2D

var GameSceneMusic
var player

func _ready():
	volume_db = GameManager.musicVolume
	playTrack()
	player = get_parent().find_node("VehicleRoot")

func playTrack():
	yield(get_tree().create_timer(0.1), "timeout")
	if not GameManager.musicMuted:
		playing = true

func _on_TitleMusic_finished():
	playTrack()

func _process(delta):
	if  player != null:
		self.position = player.position