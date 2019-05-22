extends Area2D

signal goldCollected
var worth

func _ready():
	worth = randi()%3 + 1
	if worth == 1:
		worth = 5
	elif worth == 2:
		worth = 15
	elif worth == 3:
		worth = 25
	$Label.text = str(worth)
	connect("goldCollected", GameManager, "set_gold")


func _on_Gold_area_entered(area):
	if area.name == "CollectibleArea":
		emit_signal("goldCollected", worth)
		queue_free()
