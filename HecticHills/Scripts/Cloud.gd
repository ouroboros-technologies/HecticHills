extends Sprite

var minY = 50
var maxY = 400
var endX = -220

var speed = 100

var screensize

func _ready():
	screensize = get_viewport().get_visible_rect().size

func _process(delta):
	self.position.x -= speed * delta
	
	if self.position.x <= endX:
		resetPosition()

func resetPosition():
	self.position.x = get_parent().find_node("VehicleRoot").position.x + screensize.x / 2  + 40
	# this returns null after you reset ? 
	endX = self.position.x - screensize.x
	#print("cloud position : " + str(self.position.x))
	randomize()
	self.position.y = randi() %300 -150
	speed = randi() %120 + 70
	var flip = randi() %2 +1 
	if flip == 1:
		flip_h = true
	else:
		flip_h = false
		
	randomize()
	flip = randi() %2 +1 
	if flip == 1:
		flip_v = true
	else:
		flip_v = false