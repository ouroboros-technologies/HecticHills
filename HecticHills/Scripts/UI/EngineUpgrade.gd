extends TextureButton

var gold_cost = 1000
var clicker 

func _ready():
	setTicks()
	gold_cost = GameManager.engine_level * 1000
	clicker = get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().find_node("Click")

func _on_Engine_pressed():
	if not GameManager.engine_level > 7:
		if GameManager.gold >= gold_cost:
			GameManager.set_gold(-(gold_cost))
			GameManager.engine_level += 1
			gold_cost += 1000
			print("upgraded engine level")
			setTicks()
	if not GameManager.soundMuted: 
		clicker.playing = true

func setTicks():
	if GameManager.engine_level > 1:
		get_parent().find_node("U_Tick2").visible = true
	if GameManager.engine_level > 2:
		get_parent().find_node("U_Tick3").visible = true
	if GameManager.engine_level > 3:
		get_parent().find_node("U_Tick4").visible = true
	if GameManager.engine_level > 4:
		get_parent().find_node("U_Tick5").visible = true
	if GameManager.engine_level > 5:
		get_parent().find_node("U_Tick6").visible = true
	if GameManager.engine_level > 6:
		get_parent().find_node("U_Tick7").visible = true
	if GameManager.engine_level > 7:
		get_parent().find_node("U_Tick8").visible = true
