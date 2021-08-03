extends Camera2D

var player_data = 0

func _ready():
	player_data = get_node("/root/PlayerData")
	
func _process(delta):
	position = player_data.ship_position
