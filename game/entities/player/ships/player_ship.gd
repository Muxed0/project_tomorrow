extends RigidBody2D

var ship_data = 0
var ship_texture = 0

export var ENGINE_THRUST = 700
export var RETRO_THRUST = 250
export var TORQUE = 4000

var engine_burn = 0
var retro_burn = 0
var total_thrust = 0
var spin = 0

func _ready():
	ship_data = get_node("/root/ShipData")
	
	match ship_data.ship_type:
		1:
			
			ship_texture = load("res://entities/player/ships/Ship 1.png")
		2:
			ship_texture = load("res://entities/player/ships/ship02.png")
	$ship_sprite.texture = ship_texture

func _physics_process(delta):
	total_thrust = engine_burn - retro_burn
	applied_force = Vector2(total_thrust * sin(rotation), -total_thrust * cos(rotation))
	applied_torque = TORQUE * spin
	
	ship_data.ship_position = position
	ship_data.ship_velocity = Vector3(linear_velocity.x,linear_velocity.y,angular_velocity)
	
	$"../player_cam/debug_ui/physics_fps".text = str(1/delta)

func _input(event):
	if not event.is_echo():
		if event.is_action_pressed("move_up"):
			engine_burn = ENGINE_THRUST
		elif event.is_action_released("move_up"):
			engine_burn = 0
		if event.is_action_pressed("move_down"):
			retro_burn = RETRO_THRUST
		elif event.is_action_released("move_down"):
			retro_burn = 0
		if event.is_action_pressed("move_left"):
			spin -= 1
		elif event.is_action_released("move_left"):
			spin += 1
		if event.is_action_pressed("move_right"):
			spin += 1
		elif event.is_action_released("move_right"):
			spin -= 1
	
