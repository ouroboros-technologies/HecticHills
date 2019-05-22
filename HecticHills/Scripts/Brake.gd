extends TextureButton

signal brake
signal brake_off

func _ready():
	connect("brake", find_parent("Node2D").find_node("VehicleRoot"), "brake")
	connect("brake_off", find_parent("Node2D").find_node("VehicleRoot"), "brake_off")

func _on_Brake_button_down():
	emit_signal("brake")


func _on_Brake_button_up():
	emit_signal("brake_off")
