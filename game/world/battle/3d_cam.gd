extends Camera

export var SPEED_SCALE = 0.0001

var direction = 0
var radius = 0

func _ready():
	radius = translation.z

func _process(delta):

	rotation.y += $"/root/ShipData".ship_velocity.x * SPEED_SCALE * delta
	rotation.x += $"/root/ShipData".ship_velocity.y * SPEED_SCALE * delta
	
	translation.y = - radius * sin(rotation.x)
	translation.x = radius * cos(rotation.x) * sin(rotation.y)
	translation.z = radius * cos(rotation.x) * cos(rotation.y)
	
	print(rotation.y)
	#print(translation)
