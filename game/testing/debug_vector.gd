extends Line2D

func _process(delta):
	set_point_position(0, $"../player_ship".position)
