extends Node

onready var currentScene = get_tree().get_current_scene()

var soundVolume = 0 
var musicVolume = 0
var soundMuted: bool = false
var musicMuted: bool = false

var suspension_level = 1
var engine_level = 1
var speed_level = 1
var four_wheel_drive = 1

onready var VehiclePacked = preload("res://Packed/Vehicle.tscn")
var gold = 0
var score = 0

func _ready():
	load_game()

func increment_score():
	score += 10

func set_gold(amount):
	score += 1
	gold += amount
	print(gold)

#Saves data in a dictionary format as a JSON 
func saveGameLocal():
	print("entered saveGameLocal")
	var save_game = File.new()
	save_game.open("user://savegame.save", File.WRITE)
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	
	if save_nodes.size() < 1: # if we're not in the Game Scene
		var node_data = { "sound_volume" : soundVolume, "music_volume" : musicVolume, "sound_muted": soundMuted, 
		                            "music_muted" : musicMuted, "gold" : gold, "suspension_level" : suspension_level, 
		                                    "engine_level" : engine_level, "speed_level" : speed_level,
		                                           "four_wheel_drive" : four_wheel_drive }
		save_game.store_line(to_json(node_data))
	
	else: # we are in the game scene 
		for i in save_nodes:
			var node_data = i.call("save");
			node_data["sound_volume"] = soundVolume
			node_data["music_volume"] = musicVolume 
			node_data["sound_muted"] = soundMuted
			node_data["music_muted"] = musicMuted  
			node_data["gold"] = gold
			node_data["suspension_level"] = suspension_level
			node_data["engine_level"] = engine_level
			node_data["speed_level"] = speed_level
			node_data["four_wheel_drive"] = four_wheel_drive
			save_game.store_line(to_json(node_data))
	
	save_game.close()

#scene transition and loading via function call
func setScene(scene):
	if currentScene != null:
		currentScene.queue_free()
	var s = ResourceLoader.load(scene)
	currentScene = s.instance()
	get_tree().get_root().call_deferred("add_child", currentScene)

#loads a file on device if file exists and sets all saved variables
func load_game(): 
	print("loaded game")
	var save_game = File.new()
	if not save_game.file_exists("user://savegame.save"):
		return # Error! We don't have a save to load.
	
	save_game.open("user://savegame.save", File.READ)
	var z = 0
	while not save_game.eof_reached():
		var lineCheck = save_game.get_line()
		var current_line = parse_json(lineCheck)
		print(current_line)
		if lineCheck != "":
				engine_level = int(current_line.values()[0])
				four_wheel_drive = int(current_line.values()[1])
				gold = int(current_line.values()[2])
				musicMuted = bool(current_line.values()[3])
				musicVolume = int(current_line.values()[4])
				soundMuted = bool(current_line.values()[5])
				soundVolume = int(current_line.values()[6])
				speed_level = int(current_line.values()[7])
				suspension_level = int(current_line.values()[8])
	save_game.close()

#handles back button press (pc and android)
func _notification(what):
	#Android
	if what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
		print("hello")
		if currentScene.name == "MainMenu":
			_gobackrequest()
		else: 
			setScene("res://Scenes/MainMenu.tscn")
	#PC
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		if currentScene.name == "MainMenu":
			_quitrequest()
		else: 
			setScene("res://Scenes/MainMenu.tscn")

#PC version only when clicking Close 'x' button
func _quitrequest():
	print("quit")
	saveGameLocal()
	yield(get_tree().create_timer(0.5), "timeout")
	get_tree().quit() # default behavior

#specifically android function only On pressing 'back' button on mobile
func _gobackrequest():
	print("go back")
	saveGameLocal()
	yield(get_tree().create_timer(0.5), "timeout")
	get_tree().quit() # default behavior