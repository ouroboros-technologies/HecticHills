extends TextureButton

export(String) var URL



func _on_button_pressed():
	OS.shell_open(URL)
	pass
