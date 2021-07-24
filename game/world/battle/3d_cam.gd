extends Camera

export var SPEED_SCALE = 100000

var radius = 0
var rot_speed = 0
var previous_pos = Vector3(0,0,0)
var wrap_counter = Vector2(0,0)

var a = 0
var b = 0
var z_quad = Vector2(0,0)
var z = 0
var midsection_pos = Vector3(0,0,0)

var velocity_basis = Basis(Vector3(1,0,0),Vector3(0,1,0),Vector3(0,0,1))

var ship_data = 0

signal wrap_x
signal wrap_y

func _ready():
	ship_data = get_node("/root/ShipData")
	radius = translation.z

func _process(delta):
	#Y is the rotation axis,  Z is the velocity vector in 3D, mapped on the sphere
	velocity_basis = transform.basis * Basis(Vector3(0,0,1),
										Vector3(ship_data.ship_velocity.y, ship_data.ship_velocity.x, 0).normalized(),
										Vector3(-ship_data.ship_velocity.x, ship_data.ship_velocity.y, 0).normalized())
	if ship_data.ship_velocity.length() != 0:
		rotate(velocity_basis.y, ship_data.ship_velocity.length() / SPEED_SCALE)
	
	translation.y = - radius * sin(rotation.x)
	translation.x = radius * cos(rotation.x) * sin(rotation.y)
	translation.z = radius * cos(rotation.x) * cos(rotation.y)
	
	#Solving for intersection with front half of the equatior and positioning red orb
	a = velocity_basis.y.x
	b = velocity_basis.y.z
	z_quad.x = a*a + b*b
	z_quad.y = radius*radius * a*a
	z = sqrt(4 * z_quad.x * z_quad.y)/(2 * z_quad.x)
	midsection_pos.x = -(z * b)/a
	midsection_pos.z = z
	$"../debug_indicator".translation = midsection_pos
	
	if translation.y * previous_pos.y < 0 and (translation-midsection_pos).length() < 1:
		if previous_pos.y < 0:
			print("down -> up")
		else:
			print("up -> down")
		wrap_counter.x += 1
		print(wrap_counter)

	previous_pos = translation
	$"../debug_pill".transform.basis = velocity_basis
	
	if delta != 0:
		$"../../../player_cam/debug_ui/process_fps".text = str(1/delta)
