extends Spatial

var direction = 0
export var MOVE_SPEED = 10

func _process(delta):
	$orbit_mesh.rotation.y += direction * MOVE_SPEED * delta

func _input(event):
	if not event.is_echo():
		if event.is_action_pressed("move_left"):
			direction = -1
		elif event.is_action_pressed("move_right"):
			direction = 1
		else:
			direction = 0
