extends Control

export(String) var path

func _ready():
	$AnimationPlayer.play("Fade")

func _on_Timer_timeout():
	GameManager.setScene(path)
	pass
