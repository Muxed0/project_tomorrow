extends Sprite

var player_data = 0
var spatial_viewport = 0

func _ready():
	player_data = get_node("/root/PlayerData")
	spatial_viewport = get_node("../3D_viewport")

func _process(delta):
	position = player_data.ship_position
	texture = spatial_viewport.get_texture()
