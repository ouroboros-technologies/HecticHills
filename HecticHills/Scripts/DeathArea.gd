extends Area2D

func _on_DeathArea_body_entered(body):
	if body.name == "Map":
		yield(get_tree().create_timer(2), "timeout")
		find_parent("Node2D").find_node("EndPopUp").visible = true # error finding parent Node2D on reset? 
		find_parent("VehicleRoot").dead = true
		queue_free()
