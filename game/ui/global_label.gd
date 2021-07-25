extends Label

func _process(delta):
	text = str($"/root/PlayerData".ship_position.x) + ", " + str($"/root/PlayerData".ship_position.y) + "\n" + str($"/root/PlayerData".ship_velocity.x) + "," + str($"/root/PlayerData".ship_velocity.y) + "," + str($"/root/PlayerData".ship_velocity.z)
