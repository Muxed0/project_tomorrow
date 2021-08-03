extends MeshInstance

export var SPEED_SCALE = 0.001
export var ROLL_SPEED = 10

var rollspeed

const full_circle = 2 * PI

var velocity_norm = 0
var direction = 0
var radius = 0
var rotatin = 0
var rotatin2 = 0

var ship_data = 0

signal wrap_x
signal wrap_y

func _ready():
	ship_data = get_node("/root/ShipData")
	radius = translation.z
	$"../Camera/slider_label2/zeta_slider".value = 80

func _process(delta):
	rollspeed = $"../Camera/slider_label2/v_slider".value
	
	rotate($zeta_pill.transform.basis.y, rollspeed)
	
	translation.y = - radius * sin(rotation.x)
	translation.x = radius * cos(rotation.x) * sin(rotation.y)
	translation.z = radius * cos(rotation.x) * cos(rotation.y)
	#translation.z = radius * cos(rotation.x)
	#translation.x = radius * sin(rotation.x)


func _on_phi_slider_value_changed(value):
	rotatin = value * 2 * PI / 360
	rotation.y = rotatin2 - (2 * sin(rotation.x / 2)) * rotatin2
	rotation.x = rotatin

func _on_theta_slider_value_changed(value):
	rotatin2 = value * 2 * PI / 360
	rotation.x = rotatin - (2 * sin(rotation.y / 2)) * rotatin
	rotation.y = rotatin2
	
	print(rotation/PI)


func _on_zeta_slider_value_changed(value):
	var angle = deg2rad(value - $zeta_pill.rotation_degrees.z)
	print(value, ",", $zeta_pill.rotation_degrees.z, ",", angle)
	$zeta_pill.rotation_degrees.z = value
	
	$ball_should_roll.rotate(Vector3(0,0,1),angle)
