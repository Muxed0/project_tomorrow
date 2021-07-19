extends Label

func _process(delta):
	text = str($"../../../player_ship".position.x) + ", " + str($"../../../player_ship".position.y)
