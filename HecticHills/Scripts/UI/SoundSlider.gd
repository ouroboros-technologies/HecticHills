extends HSlider

func _ready():
	tick_count = GameManager.soundVolume

func _on_SoundSlider_value_changed(value):
	GameManager.soundVolume = int(value)
	find_parent("Menus").find_node("Click").volume_db = value