extends Camera

export var CAM_MOVE_SPEED = 1

var direction = 0
var radius = 0

func _ready():
	radius = translation.z

func _process(delta):
	if Input.is_action_pressed("move_up"):
		direction = -1
	elif Input.is_action_pressed("move_down"):
		direction = 1
	else:
		direction = 0

	rotation.x += CAM_MOVE_SPEED * direction * delta
	translation.y = - radius * sin(rotation.x)
	translation.z = radius * cos(rotation.x)
