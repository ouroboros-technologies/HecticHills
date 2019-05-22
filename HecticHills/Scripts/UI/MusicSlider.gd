extends HSlider

func _ready():
	tick_count = GameManager.musicVolume

func _on_MusicSlider_value_changed(value):
	GameManager.musicVolume = int(value)
	find_parent("Menus").find_node("TitleMusic").volume_db = value
