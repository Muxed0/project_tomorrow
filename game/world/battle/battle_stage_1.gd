extends Node2D

var player = 0
var player_pos = Vector2(0,0)

func _ready():
	player = get_node("player_ship")
	

func _process(delta):
	player_pos = $player_ship.position
	$player_cam.position = player_pos
	$background.position = player_pos

	var texture = $"3D_viewport".get_texture()
	$background.texture = texture
	
func _on_3D_cam_wrap_x():
	$"3D_viewport/3D_scene/3D_cam".rotation.x = 0

func _on_3D_cam_wrap_y():
	$"3D_viewport/3D_scene/3D_cam".rotation.y = 0
