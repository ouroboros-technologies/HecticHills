extends RigidBody2D

export (float) var maxSpeed = 500
export (float) var speed = 40

export (int) var spin_thrust = 25000

var acc =  Vector2()
var vel = Vector2()

var thrust = Vector2()
var rotation_dir = 0
var screensize

var frontWheel: RigidBody2D
var frontWheelSprite
var backWheel: RigidBody2D
var backWheelSprite
var backSpring
var frontSpring

var score = 0
var positionX = 0

var dead = false

var brake = false
var gas = false
var isBrakeSoundPlaying
var isEngineSoundPlaying
var brake_just
var gas_just
var gas_just_off

var engine : AudioStreamPlayer2D
var brakes : AudioStreamPlayer2D
var crash : AudioStreamPlayer2D
var engineIdle : AudioStreamPlayer2D

onready var engine_idle = preload("res://Assets/Sounds/Jeep_idle.wav")

onready var brake_sound = preload("res://Assets/Sounds/brake_skid.wav")

func _ready():
	frontWheel = find_node("FrontWheel")
	backWheel = find_node("BackWheel")
	backSpring = find_node("BackSpring")
	frontSpring = find_node("FrontSpring")
	positionX = position.x
	#Suspension adjusts the springs Front and back
	spin_thrust += (GameManager.engine_level * 2000) - 2000
	maxSpeed += GameManager.speed_level * 25 
	frontSpring.stiffness = GameManager.suspension_level
	backSpring.stiffness = GameManager.suspension_level
	frontSpring.damping = 0.1 * GameManager.suspension_level
	backSpring.damping = 0.1 * GameManager.suspension_level
	engine = find_node("Engine")
	engineIdle = find_node("Engine_Idle")
	brakes = find_node("Brakes")
	crash = find_node("Crash")
	engine.volume_db = GameManager.soundVolume - 5
	brakes.volume_db = GameManager.soundVolume - 5
	crash.volume_db = GameManager.soundVolume - 5
	engineIdle.volume_db = GameManager.soundVolume - 7

func get_input():
	rotation_dir = 0
	if not dead:
		if gas:
			if self.linear_velocity.x < maxSpeed:
				rotation_dir += 1
		if brake:
			if self.linear_velocity.x < maxSpeed:
				rotation_dir -= 1

func _process(delta):
	get_input()
	play_sound()
	if abs(positionX  - position.x) > 200:
		GameManager.increment_score()
		print(GameManager.score)
		positionX = position.x

func _integrate_forces(state):
	backWheel.set_applied_force(thrust.rotated(rotation))
	backWheel.set_applied_torque(rotation_dir * spin_thrust)
	frontWheel.set_applied_force((thrust.rotated(rotation))/(10-GameManager.four_wheel_drive))
	frontWheel.set_applied_torque((rotation_dir * spin_thrust)/(10-GameManager.four_wheel_drive))

func gas():
	if not dead:
		gas = true
		gas_just = true
		if engine.playing:
			engine.playing = false
			_on_Engine_finished()

func gas_off():
	if not dead:
		gas = false
		gas_just_off = true
		if engine.playing:
			engine.playing = false
			_on_Engine_finished() 

func brake():
	if not dead:
		brake = true
		brake_just = true
	

func brake_off():
	if not dead:
		brake = false

func play_sound():
	if dead: 
		crash.playing = true
		engineIdle.playing = false
		engine.playing = false
		
	if not GameManager.soundMuted:
		
		if brake && !isBrakeSoundPlaying && brake_just: #and in theory is touching the ground 
			brakes.stream = brake_sound
			brakes.play()
			isBrakeSoundPlaying = true
#		if gas && !isEngineSoundPlaying:
#			if gas_just:
#				engine.stream = engine_rev_up
#				engine.play()
#				isEngineSoundPlaying = true
#			elif gas_just_off:
#				engine.stream = engine_rev_down
#				engine.play()
#				isEngineSoundPlaying = true
#			else:
		engine.play()
		isEngineSoundPlaying = true

func _on_BackWheel_body_entered(body):
	if body.name == "Map":
		pass

func _on_BackWheel_body_exited(body):
	if body.name == "Map":
		pass

func _on_Engine_finished():
	isEngineSoundPlaying = false
	if gas_just:
		gas_just = false
	if gas_just_off:
		gas_just_off = false

func _on_Brakes_finished():
	isBrakeSoundPlaying = false
	brake_just = false

