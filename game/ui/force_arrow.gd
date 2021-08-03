extends Sprite

var scale_factor = 0

func _process(delta):
	scale_factor = $"../../../player_ship".applied_force.length() / 1000.0
	scale = Vector2(scale_factor, scale_factor)
	
	rotation = $"../../../player_ship".applied_force.angle() + PI/2
