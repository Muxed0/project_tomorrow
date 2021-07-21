extends Camera

export var SPEED_SCALE = 0.0001

const full_circle = 2 * PI

var velocity_norm = 0
var direction = 0
var radius = 0
var rot_axis = Vector3(0,0,0)
var rot_speed = 0

var ship_data = 0

signal wrap_x
signal wrap_y

func _ready():
	ship_data = get_node("/root/ShipData")
	radius = translation.z

func _process(delta):
	rot_axis = ship_data.ship_velocity.normalized()
	rot_speed = ship_data.ship_velocity.length()
	if rot_speed != 0:
		rotate_object_local(Vector3(rot_axis.y,rot_axis.x,rot_axis.z), rot_speed * SPEED_SCALE)
	
	translation.y = - radius * sin(rotation.x)
	translation.x = radius * cos(rotation.x) * sin(rotation.y)
	translation.z = radius * cos(rotation.x) * cos(rotation.y)
	
	print(rotation_degrees)
