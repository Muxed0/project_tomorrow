extends Node2D

var player_pos = Vector2(0,0)

func _process(delta):
	player_pos = $player_ship_1.position
	$player_cam.position = player_pos
	#$background.position = player_pos

	var texture = $Viewport.get_texture()
	#$background.texture = texture
