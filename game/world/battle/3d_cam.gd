extends Camera

export var SPEED_SCALE = 0.001

const full_circle = 2 * PI

var direction = 0
var radius = 0

signal wrap_x
signal wrap_y

func _ready():
	radius = translation.z

func _process(delta):

	rotation.y += $"/root/ShipData".ship_velocity.x * SPEED_SCALE * delta
	rotation.x += $"/root/ShipData".ship_velocity.y * SPEED_SCALE * delta
	if abs(rotation.x) > full_circle:
		emit_signal("wrap_x")
	if abs(rotation.y) > full_circle:
		emit_signal("wrap_y")
	
	translation.y = - radius * sin(rotation.x)
	translation.x = radius * cos(rotation.x) * sin(rotation.y)
	translation.z = radius * cos(rotation.x) * cos(rotation.y)
