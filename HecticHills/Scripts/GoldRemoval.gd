extends Area2D


func _on_GoldRemoval_area_entered(area):
	if area.name == "Gold":
		area.queue_free()
		print("removed a gold")
