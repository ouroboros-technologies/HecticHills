extends Node

export var num_hills = 3
export var slice = 10
export var hill_range = 50
export var chance_for_gold = 50

onready var gold_packed  = preload("res://Packed/Gold.tscn")
onready var dirt = preload("res://Assets/dirt.tres")

var screensize
var terrain = Array()
var texture 
var totalHills = 0
var last_gold_position = 0

func _ready():
	randomize()
	screensize = get_viewport().get_visible_rect().size
	terrain = Array()
	var start_y = screensize.y * 3/4 + (-hill_range + randi() % hill_range * 2)

	terrain.append(Vector2(0, start_y))
	add_hills()
	add_hills()


func _process(delta):
	if terrain[-1].x < get_parent().find_node("VehicleRoot").position.x + screensize.x / 2:
		#print("added hills")
		add_hills()
		if $Map.get_child_count() > 5:
			$Map.get_child(0).queue_free()
	#removes map sections far behind
	if terrain.size() > 300:
		#print(terrain.size())
		#print($Line2D.get_point_count())
		terrain.remove(0)
		$Line2D.remove_point(0)



#Ground is texture, Poly is collision of ground, adds the collision area to the Map Node
func add_hills():
	var hill_width = screensize.x / num_hills
	var hill_slices = hill_width / slice
	var start = terrain[-1]
	var poly = PoolVector2Array()
	for i in range(num_hills):
		var height = randi() % hill_range
		start.y -= height
		for j in range(0, hill_slices):
			var hill_point = Vector2() 
			hill_point.x = start.x + j * slice + hill_width * i
			hill_point.y = start.y + height * cos(2 * PI / hill_slices * j) #adjusts wave spawn
			$Line2D.add_point(hill_point)
			terrain.append(hill_point)
			poly.append(hill_point)
			if totalHills > 1: 
				add_gold(hill_point) 
		start.y += height
	var shape = CollisionPolygon2D.new()
	var ground = Polygon2D.new()
	$Map.add_child(shape)
	poly.append(Vector2(terrain[-1].x, screensize.y+100))
	poly.append(Vector2(start.x, screensize.y+100))
	shape.polygon = poly
	ground.polygon = poly
	ground.texture = dirt
	add_child(ground)
	totalHills += 1

#Adds gold to spawn above the points of ground 
func add_gold(hill_point):
	var gold_spawn = randi()%100 + 1
	if gold_spawn >= 96:
		if abs(hill_point.x - last_gold_position) > 50:
			var gold = gold_packed.instance()
			gold.position.x = hill_point.x
			last_gold_position = gold.position.x
			gold.position.y = hill_point.y - 50 
			get_tree().root.call_deferred("add_child", gold)