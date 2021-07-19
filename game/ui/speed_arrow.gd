extends Sprite

var scale_factor = 0

func _process(delta):
	scale_factor = $"../../../player_ship".linear_velocity.length() / 1000.0
	scale = Vector2(scale_factor, scale_factor)
	
	rotation = $"../../../player_ship".linear_velocity.angle() + PI/2
