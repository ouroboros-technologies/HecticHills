extends Camera2D

var player

func _ready():
	player = get_parent().find_node("VehicleRoot")

func _process(delta):
	self.position = player.position