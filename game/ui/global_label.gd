extends Label

func _process(delta):
	text = str($"/root/ShipData".ship_position.x) + ", " + str($"/root/ShipData".ship_position.y) + "\n" + str($"/root/ShipData".ship_velocity.x) + "," + str($"/root/ShipData".ship_velocity.y) + "," + str($"/root/ShipData".ship_velocity.z)
