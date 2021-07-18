extends Label

func _process(delta):
	text = str($"../../player_ship_1".position.x) + ", " + str($"../../player_ship_1".position.y)
