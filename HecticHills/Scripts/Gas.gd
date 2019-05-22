extends TextureButton

signal gas
signal gas_off

func _ready():
	connect("gas", find_parent("Node2D").find_node("VehicleRoot"), "gas")
	connect("gas_off", find_parent("Node2D").find_node("VehicleRoot"), "gas_off")



func _on_Gas_button_down():
	emit_signal("gas")


func _on_Gas_button_up():
	emit_signal("gas_off")
