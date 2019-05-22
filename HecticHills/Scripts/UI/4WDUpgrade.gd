extends TextureButton

var gold_cost = 1000
var clicker

func _ready():
	setTicks()
	gold_cost = GameManager.four_wheel_drive * 1000
	clicker = find_parent("Menus").find_node("Click")

func _on_4WD_pressed():
	if not GameManager.four_wheel_drive > 7:
		if GameManager.gold >= gold_cost:
			GameManager.set_gold(-(gold_cost))
			GameManager.four_wheel_drive += 1
			gold_cost += 1000
			print("four wheel drive level: " + str(GameManager.four_wheel_drive))
			setTicks()
	if not GameManager.soundMuted: 
		clicker.playing = true

func setTicks():
	if GameManager.four_wheel_drive > 1:
		get_parent().find_node("U_Tick2").visible = true
	if GameManager.four_wheel_drive > 2:
		get_parent().find_node("U_Tick3").visible = true
	if GameManager.four_wheel_drive > 3:
		get_parent().find_node("U_Tick4").visible = true
	if GameManager.four_wheel_drive > 4:
		get_parent().find_node("U_Tick5").visible = true
	if GameManager.four_wheel_drive > 5:
		get_parent().find_node("U_Tick6").visible = true
	if GameManager.four_wheel_drive > 6:
		get_parent().find_node("U_Tick7").visible = true
	if GameManager.four_wheel_drive > 7:
		get_parent().find_node("U_Tick8").visible = true