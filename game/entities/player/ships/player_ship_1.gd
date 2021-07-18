extends RigidBody2D

export var ENGINE_THRUST = 700
export var RETRO_THRUST = 250
export var TORQUE = 4000

var engine_burn = 0
var retro_burn = 0
var total_thrust = 0

func _physics_process(delta):
	total_thrust = engine_burn - retro_burn
	applied_force = Vector2(total_thrust * sin(rotation), -total_thrust * cos(rotation))

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
			applied_torque = -TORQUE
		elif event.is_action_released("move_left"):
			applied_torque = 0
		if event.is_action_pressed("move_right"):
			applied_torque = TORQUE
		elif event.is_action_released("move_right"):
			applied_torque = 0
	
